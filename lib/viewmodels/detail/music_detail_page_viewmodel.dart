import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../models/main/music_page_model.dart';
import '../../services/favourite/music_favourite_service.dart';
import '../../services/favourite/template_favourite_service.dart';
import '../../viewmodels/detail/toggle_favorites_viewmodel.dart';

class MusicDetailPageViewModel extends ChangeNotifier with FavoriteToggleMixin {
  final MusicFavouriteService _musicFavouriteService = MusicFavouriteService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isFavorite = false;
  bool _isPlaying = false;
  bool _isRepeat = false;
  bool _isShuffle = false;

  @override
  bool get isFavorite => _isFavorite;

  @override
  void setFavorite(bool value) {
    _isFavorite = value;
  }

  @override
  BaseFavouriteService get favoriteService => _musicFavouriteService;

  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  bool get isShuffle => _isShuffle;

  Duration _currentPosition = Duration.zero;
  Duration _duration = Duration.zero;

  Duration get currentPosition => _currentPosition;
  Duration get duration => _duration;

  List<Music> _playlist = [];
  int _currentIndex = -1;
  final Random _random = Random();

  // Keep track of shuffled indices to avoid repetition
  List<int> _shuffledIndices = [];
  int _shufflePosition = 0;

  List<Music> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  Music? get currentMusic =>
      _currentIndex >= 0 && _currentIndex < _playlist.length
          ? _playlist[_currentIndex]
          : null;

  // Audio source for the playlist
  ConcatenatingAudioSource? _playlistAudioSource;

  MusicDetailPageViewModel() {
    // Listen to position updates
    _audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    // Listen to duration updates
    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((playerState) {
      _isPlaying = playerState.playing;

      // Auto-play next track when current track completes
      if (playerState.processingState == ProcessingState.completed &&
          !_isRepeat) {
        playNext();
      }

      notifyListeners();
    });

    // Listen to current index changes (important for notification sync)
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null && _currentIndex != index) {
        _currentIndex = index;
        debugPrint(
            "Index changed to: $_currentIndex (from notification or app)");
        notifyListeners();
      }
    });
  }

  // Generate shuffled indices for the playlist
  void _generateShuffledIndices() {
    _shuffledIndices = List.generate(_playlist.length, (index) => index);
    _shuffledIndices.shuffle(_random);

    // Make sure current song is at the beginning of shuffle
    if (_currentIndex >= 0 && _currentIndex < _playlist.length) {
      int currentInShuffle = _shuffledIndices.indexOf(_currentIndex);
      if (currentInShuffle != 0) {
        // Swap current song to the beginning
        _shuffledIndices[currentInShuffle] = _shuffledIndices[0];
        _shuffledIndices[0] = _currentIndex;
      }
    }

    _shufflePosition = 0;
    debugPrint("Generated shuffled indices: $_shuffledIndices");
  }

  // Set the playlist and update the view
  void setPlaylist(List<Music> playlist, [int initialIndex = 0]) {
    _playlist = playlist;
    if (playlist.isNotEmpty &&
        initialIndex >= 0 &&
        initialIndex < playlist.length) {
      _currentIndex = initialIndex;

      // Generate shuffled indices when playlist is set
      _generateShuffledIndices();

      // Create a list of audio sources with metadata for the background service
      final audioSources = playlist.map((track) {
        return AudioSource.uri(
          Uri.parse(track.audio ?? ''),
          tag: MediaItem(
            id: track.id.toString(),
            album: track.album ?? 'Unknown Album',
            title: track.title ?? 'Unknown Title',
            artist: track.artist ?? 'Unknown Artist',
            artUri:
                track.thumbnail != null ? Uri.parse(track.thumbnail!) : null,
          ),
        );
      }).toList();

      // Store the audio source for reference
      _playlistAudioSource = ConcatenatingAudioSource(children: audioSources);

      // Set the audio source playlist with shuffle mode
      _audioPlayer.setAudioSource(
        _playlistAudioSource!,
        initialIndex: initialIndex,
      );

      // Set shuffle mode on the audio player
      _audioPlayer.setShuffleModeEnabled(_isShuffle);
    }
    notifyListeners();
  }

  // Play a specific track by index
  Future<void> playTrackAtIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      try {
        await _audioPlayer.seek(Duration.zero, index: index);
        await _audioPlayer.play();

        // Update shuffle position if in shuffle mode
        if (_isShuffle) {
          _shufflePosition = _shuffledIndices.indexOf(index);
        }
      } catch (e) {
        debugPrint("Error playing track at index $index: $e");
      }
    }
  }

  // Play next track
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      // Move to next position in shuffled order
      _shufflePosition++;

      // If we've reached the end of shuffle, regenerate and start over
      if (_shufflePosition >= _shuffledIndices.length) {
        _generateShuffledIndices();
        _shufflePosition = 1; // Skip current song (at position 0)
      }

      if (_shufflePosition < _shuffledIndices.length) {
        int nextIndex = _shuffledIndices[_shufflePosition];
        debugPrint(
            "Shuffle next: position $_shufflePosition, index $nextIndex");
        await playTrackAtIndex(nextIndex);
      }
    } else {
      // Play next track in order, or loop back to the beginning
      int nextIndex = _currentIndex + 1;
      if (nextIndex >= _playlist.length) {
        nextIndex = 0; // Loop back to the first track
      }
      await playTrackAtIndex(nextIndex);
    }
  }

  // Play previous track
  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;

    // If we're at the beginning of a track, go to previous track
    // Otherwise restart the current track
    if (_currentPosition.inSeconds > 3) {
      seekTo(Duration.zero);
      return;
    }

    if (_isShuffle) {
      // Move to previous position in shuffled order
      _shufflePosition--;

      // If we're at the beginning, go to the end
      if (_shufflePosition < 0) {
        _shufflePosition = _shuffledIndices.length - 1;
      }

      int prevIndex = _shuffledIndices[_shufflePosition];
      debugPrint(
          "Shuffle previous: position $_shufflePosition, index $prevIndex");
      await playTrackAtIndex(prevIndex);
    } else {
      // Play previous track, or loop to the end
      int prevIndex = _currentIndex - 1;
      if (prevIndex < 0) {
        prevIndex = _playlist.length - 1; // Loop to the last track
      }
      await playTrackAtIndex(prevIndex);
    }
  }

  // Toggle shuffle mode
  void toggleShuffle() {
    _isShuffle = !_isShuffle;

    // Enable/disable shuffle mode on audio player
    _audioPlayer.setShuffleModeEnabled(_isShuffle);

    if (_isShuffle) {
      // Generate new shuffled order when enabling shuffle
      _generateShuffledIndices();
      debugPrint("Shuffle enabled, current position: $_shufflePosition");
    } else {
      debugPrint("Shuffle disabled");
    }

    notifyListeners();
  }

  Future<void> playMusic(String url) async {
    try {
      debugPrint("Setting URL and playing: $url");

      // For playing a single track with notification support
      final audioSource = AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: 'single_track',
          title: currentMusic?.title ?? 'Unknown Title',
          artist: currentMusic?.artist ?? 'Unknown Artist',
          album: currentMusic?.album ?? 'Unknown Album',
          artUri: currentMusic?.thumbnail != null
              ? Uri.parse(currentMusic!.thumbnail!)
              : null,
        ),
      );

      await _audioPlayer.setAudioSource(audioSource);
      await _audioPlayer.play();
      // _isPlaying will be updated by the playerStateStream listener
    } catch (e) {
      debugPrint("Error playing music: $e");
      // Handle errors
    }
  }

  void togglePlaying() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    _audioPlayer.setLoopMode(_isRepeat ? LoopMode.one : LoopMode.off);
    notifyListeners();
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    // _isPlaying will be updated by the playerStateStream listener
  }

  void seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  Future<void> checkFavoriteStatus(String musicId) async {
    final favorites = await _musicFavouriteService.getData();
    _isFavorite = favorites.data.any((music) => music.id == musicId);
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
