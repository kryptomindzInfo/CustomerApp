import 'package:beyond_wallet/api_services/get_banks_api.dart';
import 'package:beyond_wallet/models/get_banks_model.dart';
import 'package:flutter/cupertino.dart';

class GetBankController extends ChangeNotifier{
  List<Banks> banks = [];
  getBanks(String token) async {
    GetBanksResponseModel responseModel =await GetBanksApi().getBanks(token);
    banks = responseModel.banks;
    notifyListeners();
  }
}