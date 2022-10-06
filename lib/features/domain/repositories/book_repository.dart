import 'package:either_dart/either.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';

import '../../../core/error/failures.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks(
    String collectionId,
    int? limit,
  );
  Future<Either<Failure, List<BookEntity>>> getBooksByUId(
    String collectionId,
    String query,
    bool isReaded,
  );
  Future<Either<Failure, BookEntity>> getBook(
    String collectionId,
    String documentId,
  );
  Future<Either<Failure, String?>> createBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, String?>> updateBook(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, String?>> deleteBook(
    String collectionId,
    String documentId,
  );
}
