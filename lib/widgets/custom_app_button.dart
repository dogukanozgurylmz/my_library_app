import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CustomAppButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
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
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
