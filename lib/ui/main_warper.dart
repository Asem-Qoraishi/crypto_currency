import 'package:crypto_currency/ui/bottom_nav.dart';
import 'package:crypto_currency/ui/home_page.dart';
import 'package:crypto_currency/ui/market_view_page.dart';
import 'package:crypto_currency/ui/profile_page.dart';
import 'package:crypto_currency/ui/watch_list.dart';
import 'package:flutter/material.dart';

class MainWraper extends StatefulWidget {
  const MainWraper({Key? key}) : super(key: key);

  @override
  _MainWraperState createState() => _MainWraperState();
}

class _MainWraperState extends State<MainWraper> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.compare_arrows),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: _myPage),
      body: PageView(
        controller: _myPage,
        onPageChanged: (value) {
          setState(() {});
        },
        children: [
          Homepage(),
          const MarketViewPage(),
          const ProfilePage(),
          const WatchList(),
        ],
      ),
    );
  }
}
