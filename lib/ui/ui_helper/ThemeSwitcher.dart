import 'package:crypto_currency/Providers/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var swichIcon;
    if (themeProvider.isDarkMode) {
      swichIcon = const Icon(CupertinoIcons.moon_fill, color: Colors.black);
    } else {
      swichIcon = const Icon(CupertinoIcons.sun_max_fill, color: Colors.yellow);
    }
    return IconButton(
      icon: swichIcon,
      onPressed: () {
        themeProvider.toogleTheme();
      },
    );
  }
}
