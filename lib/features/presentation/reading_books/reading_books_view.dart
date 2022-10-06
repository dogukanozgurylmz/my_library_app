import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/presentation/reading_books/cubit/reading_books_cubit.dart';
import 'package:mylibraryapp/locator.dart';
import '../../../widgets/custom_app_card.dart';
import '../book_detail/book_detail_view.dart';

class ReadingBooksView extends StatelessWidget {
  const ReadingBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<ReadingBooksCubit>(),
      child: BlocBuilder<ReadingBooksCubit, ReadingBooksState>(
        builder: (context, state) {
          // final cubit = context.read<ReadingBooksCubit>();
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              backgroundColor: colorScheme.background,
              elevation: 0,
              title: Text("Reading Books",
                  style: Theme.of(context).textTheme.headline5),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.readingBooks.length,
              itemBuilder: (context, index) {
                return state.readingBooks.isEmpty
                    ? Text(
                        "Nothing",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    : state.isReadingLoading
                        ? CircularProgressIndicator(
                            color: colorScheme.primary,
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 10),
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BookDetailView(
                                      bookEntity: state.readingBooks[index],
                                    ),
                                  ));
                                },
                                child: CustomAppCard(
                                  bookName: state.readingBooks[index].bookName,
                                  bookType: state.readingBooks[index].bookType,
                                  author: state.readingBooks[index].author,
                                  isReaded: state.readingBooks[index].isReaded,
                                  totalPages:
                                      state.readingBooks[index].totalPages,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
              },
            ),
          );
        },
      ),
    );
  }
}
