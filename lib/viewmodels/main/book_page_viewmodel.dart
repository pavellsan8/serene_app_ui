import '../../models/main/book_page_model.dart';
import '../../../services/main/book_page_service.dart';
import '../../viewmodels/main/generic_page_viewmodel.dart';

class BookPageViewModel extends GenericPageViewModel<Book> {
  final BookService bookService = BookService();

  // Override fetchData to return books
  @override
  Future<List<Book>> fetchData() async {
    final BookResponse response = await bookService.getBookData();
    return response.data;
  }
}
