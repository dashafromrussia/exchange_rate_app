abstract class ExchangeEvent{
  const ExchangeEvent();
}

class GetAllDataExchangeEvent extends ExchangeEvent{}

class ConvertFirstValueExchangeEvent extends ExchangeEvent{
final double? value;
const ConvertFirstValueExchangeEvent({required this.value});
}

class ConvertSecondValueExchangeEvent extends ExchangeEvent{
  final double? value;
  const ConvertSecondValueExchangeEvent({required this.value});
}

class ReverseValueExchangeEvent extends ExchangeEvent{

const ReverseValueExchangeEvent();
}

class ChangeFirstCurrencyExchangeEvent extends ExchangeEvent{
  final String value;
  ChangeFirstCurrencyExchangeEvent({required this.value});
}

class ChangeSecondCurrencyExchangeEvent extends ExchangeEvent{
  final String value;
  ChangeSecondCurrencyExchangeEvent({required this.value});
}

