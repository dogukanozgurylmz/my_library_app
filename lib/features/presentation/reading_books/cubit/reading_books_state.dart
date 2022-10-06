part of 'reading_books_cubit.dart';

class ReadingBooksState extends Equatable {
  final List<BookEntity> readingBooks;
  final bool isReadingLoading;

  const ReadingBooksState({
    required this.readingBooks,
    required this.isReadingLoading,
  });

  ReadingBooksState copyWith({
    List<BookEntity>? readingBooks,
    bool? isReadingLoading,
  }) {
    return ReadingBooksState(
      readingBooks: readingBooks ?? this.readingBooks,
      isReadingLoading: isReadingLoading ?? this.isReadingLoading,
    );
  }

  @override
  List<Object> get props => [
        readingBooks,
        isReadingLoading,
      ];
}
