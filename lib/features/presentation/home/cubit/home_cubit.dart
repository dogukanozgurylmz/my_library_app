import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylibraryapp/features/data/datasource/mylibrary_auth.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';
import 'package:mylibraryapp/features/domain/usecases/book/get_books_by_uid.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBooksByUIdUseCase _getBooksByUId;

  HomeCubit({required GetBooksByUIdUseCase getBooksByUId})
      : _getBooksByUId = getBooksByUId,
        super(const HomeState(
          readedBooks: [],
          readingBooks: [],
          totalPages: 0,
          totalWords: 0,
          isReadedLoading: false,
          isReadingLoading: false,
        )) {
    init();
  }

  Future<void> init() async {
    await getBooksByUIdReaded();
    await getBooksByUIdReading();
    totalPagesCount();
    totalWordsCount();
  }

  Future<void> signOutWithGoogle() async {
    await MyLibraryAuth().signOutGoogle();
  }

  Future<void> getBooksByUIdReaded() async {
    emit(state.copyWith(isReadedLoading: true, readedBooks: []));
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

  Future<void> getBooksByUIdReading() async {
    emit(state.copyWith(isReadingLoading: true, readingBooks: []));
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

  void totalPagesCount() {
    int totalPages = 0;
    for (var book in state.readedBooks) {
      totalPages = totalPages + book.totalPages;
    }
    emit(state.copyWith(totalPages: totalPages));
  }

  void totalWordsCount() {
    //272
    int totalWords = 0;
    for (var book in state.readedBooks) {
      totalWords = totalWords + (book.totalPages * 272);
    }
    emit(state.copyWith(totalWords: totalWords));
  }
}
