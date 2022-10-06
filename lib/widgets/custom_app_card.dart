import 'package:flutter/material.dart';

class CustomAppCard extends StatelessWidget {
  final String bookName;
  final String author;
  final String bookType;
  final int totalPages;
  final bool isReaded;

  const CustomAppCard({
    Key? key,
    required this.bookName,
    required this.author,
    required this.bookType,
    required this.totalPages,
    required this.isReaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: colorScheme.onBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(150),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bookName,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bookType,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    author,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$totalPages pages",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: ColoredBox(
                          color: isReaded
                              ? colorScheme.onPrimary
                              : colorScheme.error,
                          child: const SizedBox(
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isReaded ? "Readed" : "Reading",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: colorScheme.onSurface),
                      )
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/images/book.png',
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
