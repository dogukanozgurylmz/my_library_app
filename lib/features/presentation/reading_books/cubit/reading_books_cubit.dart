import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylibraryapp/features/domain/usecases/book/get_books_by_uid.dart';

import '../../../data/datasource/mylibrary_auth.dart';
import '../../../domain/entities/book_entity.dart';

part 'reading_books_state.dart';

class ReadingBooksCubit extends Cubit<ReadingBooksState> {
  final GetBooksByUIdUseCase _getBooksByUId;

  ReadingBooksCubit({required GetBooksByUIdUseCase getBooksByUId})
      : _getBooksByUId = getBooksByUId,
        super(const ReadingBooksState(
          readingBooks: [],
          isReadingLoading: false,
        )) {
    init();
  }

  Future<void> init() async {
    await getBooksByUIdReading();
  }

  Future<void> getBooksByUIdReading() async {
    emit(state.copyWith(isReadingLoading: true));
    List<BookEntity> readingBooks = [];
    final result = await _getBooksByUId.call(GetBooksByUIdParams(
      collectionId: 'books',
      query: MyLibraryAuth().firebaseAuth.currentUser!.uid,
      isReaded: false,
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is List<BookEntity>) {
      readingBooks.addAll(either);
      readingBooks.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
      emit(state.copyWith(readingBooks: readingBooks));
    }
    emit(state.copyWith(isReadingLoading: false));
  }
}
