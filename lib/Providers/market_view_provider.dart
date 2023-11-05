import 'package:crypto_currency/Models/CryptoModel/AllCryptoModel.dart';
import 'package:crypto_currency/network/api_service.dart';
import 'package:crypto_currency/network/crypto_repository.dart';
import 'package:flutter/material.dart';

class MarketViewProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  late AllCryptoModel cryptoData;
  late CryptoResponseModel state;
  var response;

  getData({int start = 1, int limit = 30}) async {
    state = CryptoResponseModel.loading('Loading ....');
    try {
      response = await apiService.getPaginatedData(start, limit);
      if (response.statusCode == 200) {
        cryptoData = AllCryptoModel.fromJson(response.data);
        state = CryptoResponseModel.completed(cryptoData);
      } else {
        state = CryptoResponseModel.error('Somthing is worng');
      }
    } catch (e) {
      state = CryptoResponseModel.error('Check you network connection!');
    } finally {
      notifyListeners();
    }
  }

  getCryptoData({int? start = 0, int? limit = 30}) async {
    // start loading api
    state = CryptoResponseModel.loading("is loading...");
    // notifyListeners();

    try {
      response = await apiService.getPaginatedData(0, 30);
      if (response.statusCode == 200) {
        cryptoData = AllCryptoModel.fromJson(response.data);
        state = CryptoResponseModel.completed(cryptoData);
      } else {
        state = CryptoResponseModel.error("something wrong please try again...");
      }
      notifyListeners();
    } catch (e) {
      state = CryptoResponseModel.error("please check your connection...");
      notifyListeners();

      print(e.toString());
    }
  }
}
