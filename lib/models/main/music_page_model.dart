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
  final String? title;
  final String? videoId;
  final String? ytLink;
  final String? artist;
  final String? album;
  final String? duration;
  final String? thumbnail;

  Music({
    this.title,
    this.videoId,
    this.ytLink,
    this.artist,
    this.album,
    this.duration,
    this.thumbnail,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      title: json['title'],
      videoId: json['video_id'],
      ytLink: json['youtube_link'],
      artist: json['artist'],
      album: json['album'],
      duration: json['duration'],
      thumbnail: json['thumbnail'],
    );
  }
}
