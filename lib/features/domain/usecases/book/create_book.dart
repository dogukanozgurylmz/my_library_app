import 'package:either_dart/either.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/book_repository.dart';

class CreateBookUseCase extends UseCase<String?, CreateBookParams> {
  final BookRepository bookRepository;

  CreateBookUseCase({
    required this.bookRepository,
  });

  @override
  Future<Either<Failure, String?>> call(
    CreateBookParams params,
  ) async {
    final result = await bookRepository.createBook(
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

class CreateBookParams {
  final String collectionId;
  final String documentId;
  final Map<String, dynamic> data;

  CreateBookParams({
    required this.collectionId,
    required this.documentId,
    required this.data,
  });
}
