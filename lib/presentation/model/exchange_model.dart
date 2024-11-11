class ExchangeModel{
  final double? firstValue;
  final double? secondValue;
  final String firstName;
  final String secondName;
  final Map<String,dynamic> rates;
  const ExchangeModel({required this.rates,required this.firstName,
  required this.secondName,required this.firstValue,required this.secondValue});

ExchangeModel copyWith({
  double? firstValue,
  double? secondValue,
  String? firstName,
  String? secondName,
  Map<String,dynamic>? rates
}) {
  return ExchangeModel(
      rates: rates??this.rates,
      firstName: firstName?? this.firstName,
      secondName: secondName??this.secondName,
      firstValue: firstValue,
      secondValue: secondValue);
}

}