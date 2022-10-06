part of 'add_book_cubit.dart';

class AddBookState extends Equatable {
  final bool switchValue;
  final bool isLoaded;

  const AddBookState({
    required this.switchValue,
    required this.isLoaded,
  });

  AddBookState copyWith({
    bool? switchValue,
    bool? isLoaded,
  }) {
    return AddBookState(
      switchValue: switchValue ?? this.switchValue,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  @override
  List<Object> get props => [
        switchValue,
        isLoaded,
      ];
}
