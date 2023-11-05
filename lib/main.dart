import 'package:crypto_currency/Providers/ThemeProvider.dart';
import 'package:crypto_currency/Providers/bottom_nav_provider.dart';
import 'package:crypto_currency/Providers/choices_chip_provider.dart';
import 'package:crypto_currency/Providers/crypto_list_provider.dart';
import 'package:crypto_currency/Providers/market_view_provider.dart';
import 'package:crypto_currency/data/sharedPreferences.dart';
import 'package:crypto_currency/size_config.dart';
import 'package:crypto_currency/ui/main_warper.dart';
import 'package:crypto_currency/ui/profile_page.dart';
import 'package:crypto_currency/ui/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => BottomNavProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChoicesChipProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CryptoListProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MarketViewProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              //if we recieved the data
              if (snapshot.hasData) {
                SharedPreferences sharedPreferences = snapshot.data!;
                bool isLogedIn = sharedPreferences.getBool(SharedPref.logedIn) ?? false;

                if (isLogedIn) {
                  return const MainWraper();
                }
                return const SignUpPage();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ));
    });
  }
}
