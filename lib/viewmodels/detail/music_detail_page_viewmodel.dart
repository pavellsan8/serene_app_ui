import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

  List<Music> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  Music? get currentMusic =>
      _currentIndex >= 0 && _currentIndex < _playlist.length
          ? _playlist[_currentIndex]
          : null;

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
  }

  // Set the playlist and update the view
  void setPlaylist(List<Music> playlist, [int initialIndex = 0]) {
    _playlist = playlist;
    if (playlist.isNotEmpty &&
        initialIndex >= 0 &&
        initialIndex < playlist.length) {
      _currentIndex = initialIndex;
    }
    notifyListeners();
  }

  // Play a specific track by index
  Future<void> playTrackAtIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      _currentIndex = index;
      final Music track = _playlist[index];
      if (track.audio != null && track.audio!.isNotEmpty) {
        await playMusic(track.audio!);
        notifyListeners(); // This should be after awaiting playMusic
      } else {
        debugPrint("No audio URL available for track at index $index");
      }
    }
  }

  // Play next track
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      if (_playlist.length > 1) {
        int nextIndex;
        do {
          nextIndex = _random.nextInt(_playlist.length);
        } while (nextIndex == _currentIndex && _playlist.length > 1);

        await playTrackAtIndex(nextIndex);
      } else {
        await playTrackAtIndex(0); // Only one track, replay it
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
      // Play random track excluding current one if possible
      if (_playlist.length > 1) {
        int prevIndex;
        do {
          prevIndex = _random.nextInt(_playlist.length);
        } while (prevIndex == _currentIndex && _playlist.length > 1);

        await playTrackAtIndex(prevIndex);
      } else {
        await playTrackAtIndex(0); // Only one track, replay it
      }
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
    notifyListeners();
  }

  Future<void> playMusic(String url) async {
    try {
      debugPrint("Setting URL and playing: $url");
      await _audioPlayer.setUrl(url);
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
