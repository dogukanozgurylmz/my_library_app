import 'package:either_dart/either.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUsersUseCase extends UseCase<List<UserEntity>, GetUsersParams> {
  final UserRepository userRepository;

  GetUsersUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> call(GetUsersParams params) async {
    final result = await userRepository.getUsers(
      params.collectionId,
      params.limit,
    );
    final either = result.fold((l) => l, (r) => r);
    if (either is List<UserEntity> && either.isNotEmpty) {
      return Right(either);
    }
    return Left(ServerFailure());
  }
}

class GetUsersParams {
  final String collectionId;
  final int? limit;

  GetUsersParams({
    required this.collectionId,
    required this.limit,
  });
}
