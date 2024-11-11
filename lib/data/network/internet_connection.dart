import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@lazySingleton
class InternetConnectionService{
  final InternetConnection _connectivity;
  InternetConnectionService(this._connectivity);

  Stream<InternetStatus> get isConnection => InternetConnection().onStatusChange;
  InternetConnection get internetConnection=> InternetConnection();

}