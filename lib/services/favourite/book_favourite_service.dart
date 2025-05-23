import '../../models/main/book_page_model.dart';
import '../../services/favourite/template_favourite_service.dart';

class BookFavouriteService extends BaseFavouriteService<BookResponse> {
  BookFavouriteService() : super("book", "book_id");

  @override
  BookResponse parseResponse(Map<String, dynamic> json) {
    return BookResponse.fromJson(json);
  }
}
