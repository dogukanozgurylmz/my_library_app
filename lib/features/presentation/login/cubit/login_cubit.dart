import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylibraryapp/features/data/datasource/mylibrary_auth.dart';
import 'package:mylibraryapp/features/domain/entities/user_entity.dart';
import 'package:mylibraryapp/features/domain/usecases/user/create_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final CreateUserUseCase _createUser;

  LoginCubit({required CreateUserUseCase createUser})
      : _createUser = createUser,
        super(const LoginState(
          isSignIn: false,
        ));

  void init() {
    if (MyLibraryAuth().firebaseAuth.currentUser != null) {
      emit(state.copyWith(isSignIn: true));
    }
  }

  Future<void> signInWithGoogle() async {
    await MyLibraryAuth().signInWithGoogle();
    await createUser();
  }

  Future<void> createUser() async {
    final currentUser = MyLibraryAuth().firebaseAuth.currentUser;
    UserEntity userEntity = UserEntity(
      id: currentUser!.uid,
      displayName: currentUser.displayName ?? "",
      email: currentUser.email ?? "",
      phoneNumber: currentUser.phoneNumber ?? "",
      photoUrl: currentUser.photoURL ?? "",
      emailVerified: currentUser.emailVerified,
    );
    final result = await _createUser.call(CreateUserParams(
      collectionId: 'users',
      documentId: currentUser.uid,
      data: userEntity.toJson(),
    ));
    final either = result.fold((left) => left, (right) => right);
    if (either is String) {}
  }
}
