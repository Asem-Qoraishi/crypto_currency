import 'package:crypto_currency/Models/CryptoModel/AllCryptoModel.dart';
import 'package:crypto_currency/network/api_service.dart';
import 'package:crypto_currency/network/crypto_repository.dart';
import 'package:flutter/material.dart';

class CryptoListProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  late AllCryptoModel cryptoData;
  late CryptoResponseModel state;
  var response;

  getTopMarketCupData() async {
    state = CryptoResponseModel.loading('is loading ....');
    notifyListeners();
    try {
      response = await apiService.getTopMarketCupTockens();
      // notifyListeners();
      if (response.statusCode == 200) {
        cryptoData = AllCryptoModel.fromJson(response.data);
        state = CryptoResponseModel.completed(cryptoData);
      } else {
        state = CryptoResponseModel.error('Somthing is wrong!');
      }
    } catch (e) {
      state = CryptoResponseModel.error('Please check your network and try again');
    } finally {
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = CryptoResponseModel.loading('is loading ....');
    notifyListeners();
    try {
      response = await apiService.getToGainerTokens();

      if (response.statusCode == 200) {
        cryptoData = AllCryptoModel.fromJson(response.data);
        state = CryptoResponseModel.completed(cryptoData);
      } else {
        state = CryptoResponseModel.error('Somthing is wrong!');
      }
    } catch (e) {
      state = CryptoResponseModel.error('Please check your network and try again');
    } finally {
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = CryptoResponseModel.loading('is loading ....');
    notifyListeners();
    try {
      response = await apiService.getToLoserTokens();

      if (response.statusCode == 200) {
        cryptoData = AllCryptoModel.fromJson(response.data);
        state = CryptoResponseModel.completed(cryptoData);
      } else {
        state = CryptoResponseModel.error('Somthing is wrong!');
      }
    } catch (e) {
      state = CryptoResponseModel.error('Please check your network and try again');
    } finally {
      notifyListeners();
    }
  }
}
