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
  final String title;
  final List<String>? authors;
  final String? description;
  final int? pages;
  final String? date;
  final String? thumbnail;
  final String? url;

  Book({
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
      title: json['title'],
      authors:
          (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'],
      pages: json['pages'],
      date: json['published_date'],
      thumbnail: json['thumbnail'],
      url: json['web_reader'],
    );
  }

  String get authorsAsString {
    if (authors == null || authors!.isEmpty) {
      return 'Unknown Author';
    }
    return authors!.join(', ');
  }
}
