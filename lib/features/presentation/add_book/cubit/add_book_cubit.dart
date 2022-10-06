import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylibraryapp/features/data/datasource/mylibrary_auth.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';
import 'package:mylibraryapp/features/domain/usecases/book/create_book.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController bookTypeController = TextEditingController();
  TextEditingController totalPagesController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  final CreateBookUseCase _createBook;

  AddBookCubit({required CreateBookUseCase createBook})
      : _createBook = createBook,
        super(const AddBookState(
          switchValue: false,
          isLoaded: false,
        ));

  void checkSwitchValue(bool value) {
    emit(state.copyWith(switchValue: value));
  }

  Future<void> createNewBook() async {
    emit(state.copyWith(isLoaded: true));
    var newDocId = FirebaseFirestore.instance.collection('books').doc().id;
    BookEntity bookEntity = BookEntity(
      id: newDocId,
      userId: MyLibraryAuth().firebaseAuth.currentUser!.uid,
      bookName: bookNameController.text.trim(),
      author: authorController.text.trim(),
      bookType: bookTypeController.text.trim(),
      totalPages: int.parse(totalPagesController.text.trim()),
      createdAt: Timestamp.now(),
      isReaded: state.switchValue,
    );
    final result = await _createBook.call(CreateBookParams(
      collectionId: 'books',
      documentId: newDocId,
      data: bookEntity.toJson(),
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is String) {
      // formKey.
    }
    bookNameController.text = "";
    authorController.text = "";
    bookTypeController.text = "";
    totalPagesController.text = "";
    emit(state.copyWith(switchValue: false, isLoaded: false));
  }
}
