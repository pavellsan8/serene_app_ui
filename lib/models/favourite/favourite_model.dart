class ItemFavouriteRequest {
  final String email;
  final String itemId;

  ItemFavouriteRequest({
    required this.email,
    required this.itemId,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "item_id": itemId,
    };
  }
}

class FavouriteResponse<T> {
  final int status;
  final String message;
  final String email;
  final T itemId;

  FavouriteResponse({
    required this.status,
    required this.message,
    required this.email,
    required this.itemId,
  });

  factory FavouriteResponse.fromJson(Map<String, dynamic> json, String idKey) {
    return FavouriteResponse<T>(
      status: json["status"],
      message: json["message"],
      email: json["email"],
      itemId: json[idKey],
    );
  }
}
