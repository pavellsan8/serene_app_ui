class BookResponse {
  final int status;
  final String message;
  final String? email;
  final List<Book> data;

  BookResponse({
    required this.status,
    required this.message,
    this.email,
    required this.data,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      email: json['email'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((bookJson) => Book.fromJson(bookJson as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Book {
  final String id;
  final String title;
  final String? authors;
  final String? description;
  final int? pages;
  final int? date;
  final String? thumbnail;
  final String? url;

  Book({
    required this.id,
    required this.title,
    this.authors,
    this.description,
    this.pages,
    this.date,
    this.thumbnail,
    this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['book_id'] ?? '',
      title: json['title'] ?? '',
      authors: json['authors'] as String?,
      description: json['description'] as String?,
      pages: json['pages'] as int?,
      date: json['date'] as int?,
      thumbnail: json['thumbnail'] as String?,
      url: json['url'] as String?,
    );
  }
}
