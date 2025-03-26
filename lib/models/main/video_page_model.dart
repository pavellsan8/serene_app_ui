class VideoResponse {
  final List<Video>? data;
  final bool success;
  final String message;

  VideoResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      data: json['data'] != null
          ? List<Video>.from(json['data'].map((x) => Video.fromJson(x)))
          : null,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class Video {
  final String? title;
  final String? videoId;
  final String? ytLink;
  final String? channel;
  final String? publishedAt;
  final String? description;
  final String? thumbnail;
  final String? duration;

  Video({
    this.title,
    this.videoId,
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
