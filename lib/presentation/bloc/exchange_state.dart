import 'package:untitled4/presentation/model/exchange_model.dart';

abstract class ExchangeState{
  const ExchangeState();
}

class BeginExchangeState extends ExchangeState{
  const BeginExchangeState();
}

class ErrorDataExchangeState extends ExchangeState{
  ErrorDataExchangeState();
}

class SuccessDataExchangeState extends ExchangeState{
  final ExchangeModel exchangeModel;
  SuccessDataExchangeState({required this.exchangeModel});
}