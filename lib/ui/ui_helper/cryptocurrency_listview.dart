import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/Models/CryptoModel/CryptoData.dart';
import 'package:crypto_currency/Providers/crypto_list_provider.dart';
import 'package:crypto_currency/helpers/decimalRounder.dart';
import 'package:crypto_currency/network/crypto_repository.dart';
import 'package:crypto_currency/size_config.dart';
import 'package:crypto_currency/ui/ui_helper/shimmer_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CryptocurrencyListview extends StatelessWidget {
  const CryptocurrencyListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = Provider.of<CryptoListProvider>(context, listen: false);
    cryptoProvider.getTopMarketCupData();

    return Consumer<CryptoListProvider>(
      builder: (context, cryptoListProvider, child) {
        switch (cryptoListProvider.state.status) {
          case Status.LOADING:
            return const ShimmerListView();
          case Status.COMPLETED:
            List<CryptoData>? cryptoList = cryptoListProvider.cryptoData.data!.cryptoCurrencyList;
            return cryptoListView(context, cryptoList);
          case Status.ERROR:
            return Column(
              children: [
                Text(
                  cryptoListProvider.state.message,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ElevatedButton(
                  onPressed: () {
                    cryptoListProvider.getTopMarketCupData();
                  },
                  child: const Text('try again'),
                ),
              ],
            );
          default:
            return Container();
        }
      },
    );
  }

  Widget cryptoListView(BuildContext context, List<CryptoData>? cryptoList) {
    var textStyle = Theme.of(context).textTheme.bodySmall;
    return SizedBox(
      height: 500,
      child: ListView.separated(
        itemCount: cryptoList!.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          int itemNumber = index + 1;
          var tokenId = cryptoList[index].id;
          var tokenName = cryptoList[index].name;
          var tokenSymbol = cryptoList[index].symbol;

          MaterialColor filterColor = DecimalRounder.setColorFilter(cryptoList[index].quotes![0].percentChange24h);
          var price = DecimalRounder.removePriceDecimals(cryptoList[index].quotes![0].price);
          var percentChange24h = cryptoList[index].quotes![0].percentChange24h;

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
                                style: TextStyle(
                                  fontSize: 14,
                                  color: percentColor,
                                ),
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
    );
  }
}
