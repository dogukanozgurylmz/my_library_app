part of 'book_detail_cubit.dart';

class BookDetailState extends Equatable {
  final bool isLoading;
  final String message;

  const BookDetailState({
    required this.isLoading,
    required this.message,
  });

  BookDetailState copyWith({
    bool? isLoading,
    String? message,
  }) {
    return BookDetailState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        message,
      ];
}
