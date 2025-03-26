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
  final String? description;
  final String? page;
  final String? year;
  final String? image;
  final String? url;
  final String? download;

  Book({
    required this.id,
    this.title,
    this.subtitle,
    this.authors,
    this.description,
    this.page,
    this.year,
    this.image,
    this.url,
    this.download,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      description: json['description'],
      page: json['page'],
      year: json['year'],
      image: json['image'],
      url: json['url'],
      download: json['download'],
    );
  }
}
