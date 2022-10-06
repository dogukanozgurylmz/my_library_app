import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasource/mylibrary_auth.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/usecases/book/get_books_by_uid.dart';

part 'readed_book_state.dart';

class ReadedBooksCubit extends Cubit<ReadedBooksState> {
  final GetBooksByUIdUseCase _getBooksByUId;

  ReadedBooksCubit({required GetBooksByUIdUseCase getBooksByUId})
      : _getBooksByUId = getBooksByUId,
        super(const ReadedBooksState(
          readedBooks: [],
          isReadedLoading: false,
        )) {
    init();
  }

  Future<void> init() async {
    await getBooksByUIdReaded();
  }

  Future<void> getBooksByUIdReaded() async {
    emit(state.copyWith(isReadedLoading: true));
    List<BookEntity> readedBooks = [];
    final result = await _getBooksByUId.call(GetBooksByUIdParams(
      collectionId: 'books',
      query: MyLibraryAuth().firebaseAuth.currentUser!.uid,
      isReaded: true,
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is List<BookEntity>) {
      readedBooks.addAll(either);
      readedBooks.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
      emit(state.copyWith(readedBooks: readedBooks));
    }
    emit(state.copyWith(isReadedLoading: false));
  }
}
