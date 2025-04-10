class MusicResponse {
  final List<Music>? data;
  final bool success;
  final String message;

  MusicResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory MusicResponse.fromJson(Map<String, dynamic> json) {
    return MusicResponse(
      data: json['data'] != null
          ? List<Music>.from(json['data'].map((x) => Music.fromJson(x)))
          : null,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class Music {
  final String? id;
  final String? title;
  final String? audio;
  final String? artist;
  final String? album;
  final String? thumbnail;
  final String? duration;

  Music({
    this.id,
    this.title,
    this.audio,
    this.artist,
    this.album,
    this.thumbnail,
    this.duration,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      title: json['title'],
      audio: json['audio'],
      artist: json['artist'],
      album: json['album'],
      thumbnail: json['thumbnail'],
      duration: json['duration'],
    );
  }
}