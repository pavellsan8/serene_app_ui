class MusicResponse {
  final int status;
  final String message;
  final String? email;
  final List<Music> data;

  MusicResponse({
    required this.status,
    required this.message,
    this.email,
    required this.data,
  });

  factory MusicResponse.fromJson(Map<String, dynamic> json) {
    return MusicResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      email: json['email'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((bookJson) => Music.fromJson(bookJson as Map<String, dynamic>))
          .toList(),
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
