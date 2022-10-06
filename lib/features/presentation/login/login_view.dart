import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/presentation/home/home_view.dart';
import 'package:mylibraryapp/features/presentation/login/cubit/login_cubit.dart';

import '../../../locator.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Scaffold(
            backgroundColor: colorScheme.background,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/mylibrarylogo.png',
                      height: 200,
                      width: 200,
                    ),
                    const Spacer(),
                    Text('myLibrary',
                        style: Theme.of(context).textTheme.headline4),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        await cubit.signInWithGoogle();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: colorScheme.primary.withOpacity(0.25),
                              offset: const Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Text(
                          "Sign in with Google",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
