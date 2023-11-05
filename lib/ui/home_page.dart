import 'package:crypto_currency/Providers/choices_chip_provider.dart';
import 'package:crypto_currency/Providers/crypto_list_provider.dart';
import 'package:crypto_currency/size_config.dart';
import 'package:crypto_currency/ui/ui_helper/ThemeSwitcher.dart';
import 'package:crypto_currency/ui/ui_helper/cryptocurrency_listview.dart';
import 'package:crypto_currency/ui/ui_helper/home_slider.dart';
import 'package:crypto_currency/ui/ui_helper/moving_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  var defaultIndex = 0;
  List<String> _choicesList = ['Top MarketCaps', 'Top Gainers', 'Top Losers'];
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    final cryptoListProvider = Provider.of<CryptoListProvider>(context, listen: false);
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Crypto Cureency',
          ),
          titleTextStyle: textTheme.titleLarge,
          actions: const [
            ThemeSwitcher(),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: HomeSlider(
                      controller: _pageController,
                    )),
              ),
              const MovingText(text: 'This is a random moving text'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Buying....');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Buy'),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidht(8),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Selling....');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Sell'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Consumer<ChoicesChipProvider>(
                    builder: (context, choicesChipProvider, child) {
                      return Wrap(
                        spacing: 8,
                        children: List.generate(_choicesList.length, (index) {
                          return ChoiceChip(
                            label: Text(
                              _choicesList[index],
                              style: textTheme.titleSmall,
                            ),
                            selected: index == choicesChipProvider.defaultIndex,
                            selectedColor: Colors.blue,
                            onSelected: (value) {
                              choicesChipProvider.changeIndex(index);
                              switch (index) {
                                case 0:
                                  cryptoListProvider.getTopMarketCupData();
                                case 1:
                                  cryptoListProvider.getTopGainersData();
                                  break;
                                case 2:
                                  cryptoListProvider.getTopLosersData();
                                  break;
                              }
                            },
                          );
                        }),
                      );
                    },
                  )),
              CryptocurrencyListview(),
            ]),
          ),
        ));
  }
}
