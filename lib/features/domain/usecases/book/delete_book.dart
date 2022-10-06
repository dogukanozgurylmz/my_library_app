import 'package:either_dart/either.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/book_repository.dart';

class DeleteBookUseCase extends UseCase<String?, DeleteBookParams> {
  final BookRepository bookRepository;

  DeleteBookUseCase({
    required this.bookRepository,
  });

  @override
  Future<Either<Failure, String?>> call(
    DeleteBookParams params,
  ) async {
    final result = await bookRepository.deleteBook(
      params.collectionId,
      params.documentId,
    );

    final either = result.fold((l) => l, (r) => r);

    if (either is String && either.isNotEmpty) {
      return Right(either);
    }

    return Left(ServerFailure());
  }
}

class DeleteBookParams {
  final String collectionId;
  final String documentId;

  DeleteBookParams({
    required this.collectionId,
    required this.documentId,
  });
}
