import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylibraryapp/features/data/datasource/mylibrary_database.dart';
import 'package:mylibraryapp/features/data/model/book_model.dart';

abstract class BookDataSource {
  Future<List<BookModel>> getBooks(
    String collectionId,
    int? limit,
  );
  Future<BookModel> getBook(
    String collectionId,
    String documentId,
  );
  Future<List<BookModel>> getBooksByUId(
    String collectionId,
    String query,
    bool isReaded,
  );
  Future<String?> createBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  );
  Future<String?> updateBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  );
  Future<String?> deleteBook(
    String collectionId,
    String documentId,
  );
}

class BookDataSourceImpl extends BookDataSource {
  @override
  Future<String?> createBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    return await MyLibraryDatabase().createDatabaseDocument(
      collectionId,
      documentId,
      data,
    );
  }

  @override
  Future<String?> deleteBook(
    String collectionId,
    String documentId,
  ) async {
    return await MyLibraryDatabase().deleteDatabaseDocument(
      collectionId,
      documentId,
    );
  }

  @override
  Future<BookModel> getBook(
    String collectionId,
    String documentId,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await MyLibraryDatabase()
            .firestore
            .collection(collectionId)
            .doc(documentId)
            .get();
    Map<String, dynamic>? data = documentSnapshot.data();
    BookModel userModel = BookModel(
      id: data!['id'],
      userId: data['user_id'],
      bookName: data['book_name'],
      author: data['author'],
      bookType: data['book_type'],
      totalPages: data['total_pages'],
      createdAt: data['created_at'],
      isReaded: data['is_readed'],
    );
    return userModel;
  }

  @override
  Future<List<BookModel>> getBooks(
    String collectionId,
    int? limit,
  ) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await MyLibraryDatabase().firestore.collection(collectionId).get();
    var list =
        querySnapshot.docs.map((e) => BookModel.fromJson(e.data())).toList();

    if (list.isEmpty) {
      throw Exception('No book');
    }
    return list;
  }

  @override
  Future<String?> updateBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    return await MyLibraryDatabase().updateDatabaseDocument(
      collectionId,
      documentId,
      data,
    );
  }

  @override
  Future<List<BookModel>> getBooksByUId(
    String collectionId,
    String query,
    bool isReaded,
  ) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await MyLibraryDatabase()
            .firestore
            .collection(collectionId)
            .where('user_id', isEqualTo: query)
            .where('is_readed', isEqualTo: isReaded)
            .get();
    var list =
        querySnapshot.docs.map((e) => BookModel.fromJson(e.data())).toList();

    if (list.isEmpty) {
      throw Exception('No book');
    }
    return list;
  }
}
