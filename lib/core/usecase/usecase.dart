import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mylibraryapp/core/error/failures.dart';

abstract class UseCase<RT, T> {
  Future<Either<Failure, RT>> call(T params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
