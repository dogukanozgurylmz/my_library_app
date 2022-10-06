part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isSignIn;

  LoginState copyWith({bool? isSignIn}) {
    return LoginState(
      isSignIn: isSignIn ?? this.isSignIn,
    );
  }

  const LoginState({
    required this.isSignIn,
  });

  @override
  List<Object> get props => [
        isSignIn,
      ];
}
