import 'package:either_dart/either.dart';
import 'package:mylibraryapp/features/data/datasource/book_datasource.dart';
import 'package:mylibraryapp/features/data/model/book_model.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';
import 'package:mylibraryapp/features/domain/repositories/book_repository.dart';

import '../../../core/error/failures.dart';

typedef _GetBooks = Future<List<BookEntity>> Function();
typedef _GetBooksByUId = Future<List<BookEntity>> Function();
// typedef _GetBook = Future<BookEntity> Function();
typedef _CreateBook = Future<String?> Function();
typedef _UpdateBook = Future<String?> Function();
typedef _DeleteBook = Future<String?> Function();

class BookRepositoryImpl implements BookRepository {
  final BookDataSource _bookDatasource;

  BookRepositoryImpl(BookDataSource bookDataSource)
      : _bookDatasource = bookDataSource;

  @override
  Future<Either<Failure, String?>> createBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) {
    return _createBook(
      () async {
        final String? result = await _bookDatasource.createBook(
          collectionId,
          documentId,
          data,
        );
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, String?>> deleteBook(
      String collectionId, String documentId) {
    return _deleteBook(() async {
      final String? result = await _bookDatasource.deleteBook(
        collectionId,
        documentId,
      );
      return result;
    });
  }

  @override
  Future<Either<Failure, BookEntity>> getBook(
      String collectionId, String documentId) {
    // ignore: todo
    // TODO: implement getBook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks(
      String collectionId, int? limit) {
    return _getBooks(() async {
      final List<BookModel> result =
          await _bookDatasource.getBooks(collectionId, limit);
      final books = result
          .map((e) => BookEntity(
                id: e.id,
                userId: e.userId,
                bookName: e.bookName,
                author: e.author,
                bookType: e.bookType,
                isReaded: e.isReaded,
                totalPages: e.totalPages,
                createdAt: e.createdAt,
              ))
          .toList();
      return books;
    });
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooksByUId(
    String collectionId,
    String query,
    bool isReaded,
  ) {
    return _getBooksByUId(() async {
      final List<BookModel> result = await _bookDatasource.getBooksByUId(
        collectionId,
        query,
        isReaded,
      );
      final books = result
          .map((e) => BookEntity(
                id: e.id,
                userId: e.userId,
                bookName: e.bookName,
                author: e.author,
                bookType: e.bookType,
                isReaded: e.isReaded,
                totalPages: e.totalPages,
                createdAt: e.createdAt,
              ))
          .toList();
      return books;
    });
  }

  @override
  Future<Either<Failure, String?>> updateBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) {
    return _updateBook(() async {
      final String? result = await _bookDatasource.updateBook(
        collectionId,
        documentId,
        data,
      );
      return result;
    });
  }

  Future<Either<Failure, List<BookEntity>>> _getBooks(
    _GetBooks getBooks,
  ) async {
    try {
      final result = await getBooks();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<BookEntity>>> _getBooksByUId(
    _GetBooksByUId getBooksByUId,
  ) async {
    try {
      final result = await getBooksByUId();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, String?>> _createBook(
    _CreateBook createBook,
  ) async {
    try {
      final result = await createBook();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, String?>> _updateBook(
    _UpdateBook updateBook,
  ) async {
    try {
      final result = await updateBook();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, String?>> _deleteBook(
    _DeleteBook deleteBook,
  ) async {
    try {
      final result = await deleteBook();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
