import 'package:either_dart/either.dart';

import '../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers(
      String collectionId, int? limit);
  Future<Either<Failure, UserEntity>> getUser(
      String collectionId, String documentId);
  Future<Either<Failure, String?>> createUser(
      String collectionId, String documentId, Map<String, dynamic> data);
  Future<Either<Failure, String?>> updateUser(
      String collectionId, String documentId, Map<String, dynamic> data);
}
