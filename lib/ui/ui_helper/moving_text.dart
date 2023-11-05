import 'package:crypto_currency/size_config.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MovingText extends StatelessWidget {
  final String text;
  const MovingText({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(40),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Marquee(
          text: text,
          style: textTheme.bodySmall,
          startPadding: 12,
        ),
      ),
    );
  }
}
