part of 'readed_book_cubit.dart';

class ReadedBooksState extends Equatable {
  final List<BookEntity> readedBooks;
  final bool isReadedLoading;

  const ReadedBooksState({
    required this.readedBooks,
    required this.isReadedLoading,
  });

  ReadedBooksState copyWith({
    List<BookEntity>? readedBooks,
    bool? isReadedLoading,
  }) {
    return ReadedBooksState(
      readedBooks: readedBooks ?? this.readedBooks,
      isReadedLoading: isReadedLoading ?? this.isReadedLoading,
    );
  }

  @override
  List<Object> get props => [
        readedBooks,
        isReadedLoading,
      ];
}
