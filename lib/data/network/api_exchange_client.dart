import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ApiExchangeClient{
  final Dio _dio;
  ApiExchangeClient(this._dio);

  Future<Map<String,dynamic>> getExchangeRateData()async{
    final response = await _dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=921fe7e8d2f54dc699059290fa445c03');
    return response.data as Map<String,dynamic>;
  }

}