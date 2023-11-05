import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  PageController controller;
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, bottomNavProvider, child) {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: Theme.of(context).primaryColor,
        child: SizedBox(
          // height: 63,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndex = 0;
                        widget.controller.animateToPage(pageIndex,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      color: pageIndex == 0 ? Colors.black : Colors.white,
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pageIndex = 1;
                        widget.controller.animateToPage(pageIndex,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      color: pageIndex == 1 ? Colors.black : Colors.white,
                      icon: const Icon(
                        Icons.bar_chart_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndex = 2;
                        widget.controller.animateToPage(pageIndex,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      color: pageIndex == 2 ? Colors.black : Colors.white,
                      icon: const Icon(
                        Icons.person,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pageIndex = 3;
                        widget.controller.animateToPage(pageIndex,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      color: pageIndex == 3 ? Colors.black : Colors.white,
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
