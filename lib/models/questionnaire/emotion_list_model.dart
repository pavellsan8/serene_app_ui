class EmotionListResponse {
  final int status;
  final String message;
  final EmotionListData? data;

  EmotionListResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory EmotionListResponse.fromJson(Map<String, dynamic> json) {
    return EmotionListResponse(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] != null ? EmotionListData.fromJson(json['data']) : null,
    );
  }
}

class EmotionListData {
  final int feelingId;
  final String description;

  EmotionListData({
    required this.feelingId,
    required this.description,
  });

  factory EmotionListData.fromJson(Map<String, dynamic> json) {
    return EmotionListData(
      feelingId: json['feeling_id'],
      description: json['description'],
    );
  }
}
