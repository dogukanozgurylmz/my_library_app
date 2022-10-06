part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<BookEntity> readedBooks;
  final List<BookEntity> readingBooks;
  final int totalPages;
  final int totalWords;
  final bool isReadedLoading;
  final bool isReadingLoading;

  const HomeState({
    required this.readedBooks,
    required this.readingBooks,
    required this.totalPages,
    required this.totalWords,
    required this.isReadedLoading,
    required this.isReadingLoading,
  });

  HomeState copyWith({
    List<BookEntity>? readedBooks,
    List<BookEntity>? readingBooks,
    int? totalPages,
    int? totalWords,
    bool? isReadedLoading,
    bool? isReadingLoading,
  }) {
    return HomeState(
      readedBooks: readedBooks ?? this.readedBooks,
      readingBooks: readingBooks ?? this.readingBooks,
      totalPages: totalPages ?? this.totalPages,
      totalWords: totalWords ?? this.totalWords,
      isReadedLoading: isReadedLoading ?? this.isReadedLoading,
      isReadingLoading: isReadingLoading ?? this.isReadingLoading,
    );
  }

  @override
  List<Object> get props => [
        readedBooks,
        readingBooks,
        totalPages,
        totalWords,
        isReadedLoading,
        isReadingLoading,
      ];
}
