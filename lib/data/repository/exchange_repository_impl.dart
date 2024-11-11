import 'package:injectable/injectable.dart';
import 'package:untitled4/data/service/exchange_service.dart';
import 'package:untitled4/domain/repository/exchange_repository.dart';

@LazySingleton(as: ExchangeRepository)
class ExchangeRepositoryImpl implements ExchangeRepository{
  final ExchangeService _exchangeService;
  ExchangeRepositoryImpl(this._exchangeService);

  @override
  Future<Map<String, dynamic>> getExchangeRateData()async{
   return await _exchangeService.getExchangeRateData();
  }


}