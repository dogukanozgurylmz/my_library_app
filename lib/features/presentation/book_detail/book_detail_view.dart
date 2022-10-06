import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/domain/entities/book_entity.dart';
import 'package:mylibraryapp/features/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:mylibraryapp/locator.dart';

class BookDetailView extends StatelessWidget {
  final BookEntity bookEntity;
  const BookDetailView({
    super.key,
    required this.bookEntity,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(
        bookEntity.createdAt.millisecondsSinceEpoch);
    String createdAt =
        "${tsdate.day}.${tsdate.month}.${tsdate.year} - ${tsdate.hour}.${tsdate.minute}";

    return BlocProvider(
      create: (context) => getIt<BookDetailCubit>(),
      child: BlocBuilder<BookDetailCubit, BookDetailState>(
        builder: (context, state) {
          final cubit = context.read<BookDetailCubit>();
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              backgroundColor: colorScheme.background,
              elevation: 0,
              title: Text(
                "Detail of the book",
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  WrapText(
                    colorScheme: colorScheme,
                    title: bookEntity.bookName,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 20),
                  WrapText(
                    colorScheme: colorScheme,
                    title: bookEntity.author,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 20),
                  WrapText(
                    colorScheme: colorScheme,
                    title: bookEntity.bookType,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 20),
                  WrapText(
                    colorScheme: colorScheme,
                    title: "${bookEntity.totalPages} pages",
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 20),
                  WrapText(
                    colorScheme: colorScheme,
                    title: createdAt,
                    textTheme: textTheme,
                  ),
                  _deleteAndUpdateButtons(
                      state, colorScheme, cubit, context, textTheme),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _deleteAndUpdateButtons(
    BookDetailState state,
    ColorScheme colorScheme,
    BookDetailCubit cubit,
    BuildContext context,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bookEntity.isReaded
              ? const SizedBox(
                  width: 0,
                )
              : state.isLoading
                  ? CircularProgressIndicator(
                      color: colorScheme.primary,
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          await cubit.updateBook(bookEntity.id);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            _snackBar(
                              color: colorScheme.primary,
                              text: "Readed",
                              textTheme: textTheme,
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.4,
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
                            "Readed",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
          state.isLoading
              ? CircularProgressIndicator(
                  color: colorScheme.error,
                )
              : Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      await cubit.deleteBook(bookEntity.id);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        _snackBar(
                          color: colorScheme.error,
                          text: "Delete",
                          textTheme: textTheme,
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: colorScheme.error.withOpacity(0.25),
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Text(
                        "Delete",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  SnackBar _snackBar({
    required Color color,
    required String text,
    required TextTheme textTheme,
  }) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(5),
        height: 90,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: color.withOpacity(0.25),
                spreadRadius: 0,
              ),
            ]),
        child: Row(
          children: [
            const Icon(
              Icons.delete_rounded,
              size: 40,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: textTheme.headline6,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bookEntity.bookName,
                    style: textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
}

class WrapText extends StatelessWidget {
  const WrapText({
    Key? key,
    required this.colorScheme,
    required this.title,
    required this.textTheme,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String title;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.onBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: textTheme.headline6,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
