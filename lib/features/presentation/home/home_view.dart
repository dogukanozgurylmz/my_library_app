import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/presentation/login/login_view.dart';
import 'package:mylibraryapp/locator.dart';

import '../bottom_navbar.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
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
                  onPressed: () async {},
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await cubit.init();
              },
              color: colorScheme.primary,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
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






//keytool -list -v -keystore C:\Users\doguk\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android