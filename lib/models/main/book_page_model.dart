class BookResponse {
  final List<Book>? data;
  final bool success;
  final String message;

  BookResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      data: json['data'] != null
          ? List<Book>.from(json['data'].map((x) => Book.fromJson(x)))
          : null,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class Book {
  final String id;
  final String? title;
  final String? subtitle;
  final String? authors;
  final String? image;

  Book({
    required this.id,
    this.title,
    this.subtitle,
    this.authors,
    this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      image: json['image'],
    );
  }

  factory Book.fromMap(Map<String, String> map) {
    return Book(
      id: map['title'] ?? '', 
      title: map['title'],
      subtitle: map['subtitle'],
      authors: map['authors'],
      image: map['image'],
    );
  }
}
