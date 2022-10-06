import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final int total;
  final String cardName;
  final Color cardColor;
  final TextStyle textStyle;

  const TotalCard({
    Key? key,
    required this.total,
    required this.cardName,
    required this.cardColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 105,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: -5,
              color: cardColor.withOpacity(0.5),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            child: Text(
              total.toString(),
              style: textStyle,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              cardName,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: colorScheme.onSurface,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
