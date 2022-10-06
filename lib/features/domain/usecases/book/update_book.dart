import 'package:either_dart/either.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/book_repository.dart';

class UpdateBookUseCase extends UseCase<String?, UpdateBookParams> {
  final BookRepository bookRepository;

  UpdateBookUseCase({
    required this.bookRepository,
  });

  @override
  Future<Either<Failure, String?>> call(
    UpdateBookParams params,
  ) async {
    final result = await bookRepository.updateBook(
      params.collectionId,
      params.documentId,
      params.data,
    );

    final either = result.fold((l) => l, (r) => r);

    if (either is String && either.isNotEmpty) {
      return Right(either);
    }

    return Left(ServerFailure());
  }
}

class UpdateBookParams {
  final String collectionId;
  final String documentId;
  final Map<String, dynamic> data;

  UpdateBookParams({
    required this.collectionId,
    required this.documentId,
    required this.data,
  });
}
