import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/Models/CryptoModel/CryptoData.dart';
import 'package:crypto_currency/Providers/crypto_list_provider.dart';
import 'package:crypto_currency/Providers/market_view_provider.dart';
import 'package:crypto_currency/helpers/decimalRounder.dart';
import 'package:crypto_currency/network/crypto_repository.dart';
import 'package:crypto_currency/ui/ui_helper/market_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({Key? key}) : super(key: key);

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {
  late Timer timer;
  late TextStyle textStyle;
  @override
  void initState() {
    // TODO: implement initState
    final marketViewProvider = Provider.of<MarketViewProvider>(context, listen: false);
    marketViewProvider.getData();
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      marketViewProvider.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.bodySmall!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        title: const Text("MarketViewPage"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Consumer<MarketViewProvider>(builder: (contex, marketviewProvider, child) {
          switch (marketviewProvider.state.status) {
            case Status.LOADING:
              return MarketViewShimmer();
            case Status.COMPLETED:
              List<CryptoData>? cryptoData = marketviewProvider.cryptoData.data!.cryptoCurrencyList;
              return buildListView(cryptoData);
            case Status.ERROR:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Check your network connection',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        marketviewProvider.getCryptoData();
                      },
                      child: Text(
                        'try again',
                      ))
                ],
              );
          }
        }),
      ),
    );
  }

  Widget buildListView(List<CryptoData>? cryptoData) {
    return Column(children: [
      Expanded(
        child: ListView.separated(
          itemCount: cryptoData!.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            int itemNumber = index + 1;
            var tokenId = cryptoData[index].id;
            var tokenName = cryptoData[index].name;
            var tokenSymbol = cryptoData[index].symbol;

            MaterialColor filterColor = DecimalRounder.setColorFilter(cryptoData[index].quotes![0].percentChange24h);
            var price = DecimalRounder.removePriceDecimals(cryptoData[index].quotes![0].price);
            var percentChange24h = cryptoData[index].quotes![0].percentChange24h;

            var roundedPercentChange = DecimalRounder.removePercentDecimals(percentChange24h);
            Color percentColor = DecimalRounder.setPercentChangesColor(percentChange24h);
            Icon percentIcon = DecimalRounder.setPercentChangesIcon(percentChange24h);

            return SizedBox(
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  // Number of token in CoinMarketCap
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      '$itemNumber',
                      style: textStyle,
                    ),
                  ),
                  // Image of token
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(milliseconds: 500),
                      height: 32,
                      width: 32,
                      imageUrl: 'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
                      errorWidget: (context, url, error) {
                        print(error);
                        return const Icon(Icons.error);
                      },
                      placeholder: (context, url) => const CircularProgressIndicator(),
                    ),
                  ),
                  // Display name of Token and its symbol
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tokenName.toString(),
                          style: textStyle,
                        ),
                        Text(
                          tokenSymbol.toString(),
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),

                  // Display the chart of coin in one day
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(filterColor, BlendMode.srcATop),
                      child: SvgPicture.network(
                          'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$$price',
                              style: textStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                percentIcon,
                                Text(
                                  '$roundedPercentChange%',
                                  style: TextStyle(color: percentColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
      SizedBox(
        height: 16,
      )
    ]);
  }
}
