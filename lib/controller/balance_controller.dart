import 'package:beyond_wallet/api_services/get_balance_api.dart';
import 'package:beyond_wallet/models/get_balance_model.dart';
import 'package:flutter/cupertino.dart';

class BalanceController extends ChangeNotifier{
  double balance = 0.0;
  bool loading = true;
  getBalanceController(String token)async{
    GetBalanceResponseModel responseModel =await GetBalanceApi().getBalance(token);
    balance = responseModel.balance;
    loading = false;
    notifyListeners();
  }
}