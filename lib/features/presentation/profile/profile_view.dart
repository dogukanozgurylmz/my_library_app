import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locator.dart';
import '../bottom_navbar.dart';
import '../login/cubit/login_cubit.dart';
import '../login/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          // cubit.init();
          return Scaffold(
            backgroundColor: colorScheme.background,
            bottomNavigationBar: const MyBottomNavigationBar(),
            appBar: AppBar(
              backgroundColor: colorScheme.background,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image.asset(
                  'assets/images/mylibrarylogo.png',
                ),
              ),
              leadingWidth: 50,
              centerTitle: true,
              title: Text("myLibrary",
                  style: Theme.of(context).textTheme.headline5),
              actions: [
                IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ));
                  },
                  icon: const Icon(Icons.output_outlined),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          );
        },
      ),
    );
  }
}
