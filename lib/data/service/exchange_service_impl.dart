import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:async';
import 'package:untitled4/data/network/api_exchange_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/data/network/internet_connection.dart';
import 'package:untitled4/data/service/exchange_service.dart';

@LazySingleton(as:ExchangeService)
class ExchangeServiceImpl implements ExchangeService{
final ApiExchangeClient _apiExchangeClient;
final SharedPreferences _sharedPreferences;
final InternetConnectionService _internetConnectionService;
 //StreamSubscription? _streamSubscription;
ExchangeServiceImpl(this._apiExchangeClient,this._sharedPreferences,this._internetConnectionService);



  @override
  Future<Map<String, dynamic>> getExchangeRateData()async{
    if(!await (_internetConnectionService.internetConnection).hasInternetAccess){
      final String? shareData = _sharedPreferences.getString('exchangeData');
       if(_sharedPreferences.getString('exchangeData')!=null){
         return jsonDecode(shareData!);
       }
       throw Exception();
    }
    final result = ((await _apiExchangeClient.getExchangeRateData())['rates'] as Map<String,dynamic>);
    result["EUR"]=1.0;
    _sharedPreferences.setString('exchangeData', jsonEncode(result));
    return result;
  }

}

