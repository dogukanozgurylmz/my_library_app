import 'package:either_dart/either.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';
import 'package:mylibraryapp/features/domain/repositories/book_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetBooksByUIdUseCase
    extends UseCase<List<BookEntity>?, GetBooksByUIdParams> {
  final BookRepository bookRepository;

  GetBooksByUIdUseCase({
    required this.bookRepository,
  });

  @override
  Future<Either<Failure, List<BookEntity>?>> call(
    GetBooksByUIdParams params,
  ) async {
    final result = await bookRepository.getBooksByUId(
      params.collectionId,
      params.query,
      params.isReaded,
    );

    final either = result.fold((l) => l, (r) => r);

    if (either is List<BookEntity> && either.isNotEmpty) {
      return Right(either);
    }

    return Left(ServerFailure());
  }
}

class GetBooksByUIdParams {
  final String collectionId;
  final String query;
  final bool isReaded;

  GetBooksByUIdParams({
    required this.collectionId,
    required this.query,
    required this.isReaded,
  });
}
