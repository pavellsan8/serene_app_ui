class VideoResponse {
  final int status;
  final String message;
  final String? email;
  final List<Video> data;

  VideoResponse({
    required this.status,
    required this.message,
    this.email,
    required this.data,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      email: json['email'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((bookJson) => Video.fromJson(bookJson as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Video {
  final String? title;
  final String videoId;
  final String? ytLink;
  final String? channel;
  final String? publishedAt;
  final String? description;
  final String? thumbnail;
  final String? duration;

  Video({
    this.title,
    required this.videoId,
    this.ytLink,
    this.channel,
    this.publishedAt,
    this.description,
    this.thumbnail,
    this.duration,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      videoId: json['video_id'],
      ytLink: json['youtube_link'],
      channel: json['channel'],
      publishedAt: json['published_at'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      duration: json['duration'],
    );
  }
}
