import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/presentation/add_book/add_book_view.dart';
import 'package:mylibraryapp/features/presentation/book_detail/book_detail_view.dart';
import 'package:mylibraryapp/features/presentation/login/login_view.dart';
import 'package:mylibraryapp/features/presentation/readed_books/readed_books_view.dart';
import 'package:mylibraryapp/features/presentation/reading_books/reading_books_view.dart';
import 'package:mylibraryapp/locator.dart';

import '../../../widgets/custom_app_button.dart';
import '../../../widgets/custom_app_card.dart';
import '../../../widgets/total_card.dart';
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
                    await cubit.signOutWithGoogle();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ));
                  },
                  icon: const Icon(Icons.output_outlined),
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
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ReadingBooksView(),
                        ));
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reading books",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    state.readingBooks.isEmpty
                        ? Text(
                            "Nothing",
                            style: Theme.of(context).textTheme.headline4,
                          )
                        : state.isReadingLoading
                            ? CircularProgressIndicator(
                                color: colorScheme.primary,
                              )
                            : InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BookDetailView(
                                      bookEntity: state.readingBooks.first,
                                    ),
                                  ));
                                },
                                child: CustomAppCard(
                                  bookName: state.readingBooks.first.bookName,
                                  bookType: state.readingBooks.first.bookType,
                                  author: state.readingBooks.first.author,
                                  isReaded: state.readingBooks.first.isReaded,
                                  totalPages:
                                      state.readingBooks.first.totalPages,
                                ),
                              ),
                    const SizedBox(height: 20),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ReadedBooksView(),
                        ));
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Readed books",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    state.readedBooks.isEmpty
                        ? Text(
                            "Nothing",
                            style: Theme.of(context).textTheme.headline4,
                          )
                        : state.isReadedLoading
                            ? CircularProgressIndicator(
                                color: colorScheme.primary,
                              )
                            : InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BookDetailView(
                                      bookEntity: state.readedBooks.first,
                                    ),
                                  ));
                                },
                                child: CustomAppCard(
                                  bookName: state.readedBooks.first.bookName,
                                  bookType: state.readedBooks.first.bookType,
                                  author: state.readedBooks.first.author,
                                  isReaded: state.readedBooks.first.isReaded,
                                  totalPages:
                                      state.readedBooks.first.totalPages,
                                ),
                              ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TotalCard(
                          total: state.readedBooks.length,
                          cardName: "Books",
                          cardColor: colorScheme.error,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                        TotalCard(
                          total: state.totalPages,
                          cardName: "Pages",
                          cardColor: colorScheme.primary,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                        TotalCard(
                          total: state.totalWords,
                          cardName: "Words",
                          cardColor: colorScheme.secondary,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomAppButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddBookView(),
                        ));
                      },
                      text: "Add new book",
                    ),
                    const SizedBox(height: 20),
                    // CustomAppButton(
                    //   onTap: () {},
                    //   text: "See all books",
                    // ),
                    // const SizedBox(height: 20),
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