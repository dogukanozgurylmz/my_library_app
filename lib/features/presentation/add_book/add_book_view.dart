import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapp/features/presentation/add_book/cubit/add_book_cubit.dart';
import 'package:mylibraryapp/locator.dart';
import 'package:mylibraryapp/widgets/custom_app_button.dart';

class AddBookView extends StatelessWidget {
  const AddBookView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => getIt<AddBookCubit>(),
      child: BlocBuilder<AddBookCubit, AddBookState>(
        builder: (context, state) {
          final cubit = context.read<AddBookCubit>();
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              backgroundColor: colorScheme.background,
              elevation: 0,
              title: Text("Add new book",
                  style: Theme.of(context).textTheme.headline5),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomAppTextFormField(
                        controller: cubit.bookNameController,
                        colorScheme: colorScheme,
                        text: "Book name",
                      ),
                      const SizedBox(height: 20),
                      CustomAppTextFormField(
                        controller: cubit.authorController,
                        colorScheme: colorScheme,
                        text: "Author",
                      ),
                      const SizedBox(height: 20),
                      CustomAppTextFormField(
                        controller: cubit.bookTypeController,
                        colorScheme: colorScheme,
                        text: "Book type",
                      ),
                      const SizedBox(height: 20),
                      CustomAppTextFormField(
                        controller: cubit.totalPagesController,
                        colorScheme: colorScheme,
                        text: "Total pages",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Reading",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Switch(
                            value: state.switchValue,
                            onChanged: (value) {
                              cubit.checkSwitchValue(value);
                            },
                            activeColor: colorScheme.onPrimary,
                            activeTrackColor:
                                colorScheme.onPrimary.withOpacity(0.3),
                            inactiveThumbColor: colorScheme.error,
                            inactiveTrackColor:
                                colorScheme.error.withOpacity(0.3),
                          ),
                          Text(
                            "Readed",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      state.isLoaded
                          ? CircularProgressIndicator(
                              color: colorScheme.primary,
                            )
                          : CustomAppButton(
                              text: "Add new book",
                              onTap: () async {
                                await cubit.createNewBook();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                            ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class CustomAppTextFormField extends StatelessWidget {
  final String text;
  final ColorScheme colorScheme;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomAppTextFormField({
    Key? key,
    required this.colorScheme,
    required this.text,
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.headline6,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.onBackground,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        hintText: text,
        hintStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: colorScheme.onError),
      ),
    );
  }
}
