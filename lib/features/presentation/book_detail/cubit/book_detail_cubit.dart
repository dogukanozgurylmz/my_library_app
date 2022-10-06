import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylibraryapp/features/domain/usecases/book/delete_book.dart';
import 'package:mylibraryapp/features/domain/usecases/book/update_book.dart';

part 'book_detail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  final DeleteBookUseCase _deleteBook;
  final UpdateBookUseCase _updateBook;

  BookDetailCubit({
    required DeleteBookUseCase deleteBook,
    required UpdateBookUseCase updateBook,
  })  : _deleteBook = deleteBook,
        _updateBook = updateBook,
        super(const BookDetailState(
          isLoading: false,
          message: '',
        ));

  Future<void> deleteBook(String documentId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteBook.call(DeleteBookParams(
      collectionId: 'books',
      documentId: documentId,
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is String) {
      emit(state.copyWith(message: "Deleted"));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> updateBook(String documentId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateBook.call(UpdateBookParams(
      collectionId: 'books',
      documentId: documentId,
      data: {'is_readed': true},
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is String) {
      emit(state.copyWith(message: "Updated"));
    }
    emit(state.copyWith(isLoading: false));
  }
}
