import 'dart:async';

import 'package:injectable/injectable.dart';

abstract class ExchangeService{
  Future<Map<String,dynamic>> getExchangeRateData();
}