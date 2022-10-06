import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/locator.dart';
import '../../../widgets/custom_app_card.dart';
import '../book_detail/book_detail_view.dart';
import 'cubit/readed_book_cubit.dart';

class ReadedBooksView extends StatelessWidget {
  const ReadedBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<ReadedBooksCubit>(),
      child: BlocBuilder<ReadedBooksCubit, ReadedBooksState>(
        builder: (context, state) {
          // final cubit = context.read<ReadedBooksCubit>();
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
              itemCount: state.readedBooks.length,
              itemBuilder: (context, index) {
                return state.readedBooks.isEmpty
                    ? Text(
                        "Nothing",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    : state.isReadedLoading
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
                                      bookEntity: state.readedBooks[index],
                                    ),
                                  ));
                                },
                                child: CustomAppCard(
                                  bookName: state.readedBooks[index].bookName,
                                  bookType: state.readedBooks[index].bookType,
                                  author: state.readedBooks[index].author,
                                  isReaded: state.readedBooks[index].isReaded,
                                  totalPages:
                                      state.readedBooks[index].totalPages,
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
