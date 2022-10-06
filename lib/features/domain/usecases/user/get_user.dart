import 'package:either_dart/either.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUserUseCase extends UseCase<UserEntity, GetUserParams> {
  final UserRepository userRepository;

  GetUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(GetUserParams params) async {
    final result = await userRepository.getUser(
      params.collectionId,
      params.documentId,
    );
    final either = result.fold((l) => l, (r) => r);
    if (either is UserEntity && either.toString().isNotEmpty) {
      return Right(either);
    }
    return Left(ServerFailure());
  }
}

class GetUserParams {
  final String collectionId;
  final String documentId;

  GetUserParams({
    required this.collectionId,
    required this.documentId,
  });
}
