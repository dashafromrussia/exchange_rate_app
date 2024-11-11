// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i6;
import 'package:untitled4/app_module_injectable.dart' as _i12;
import 'package:untitled4/data/network/api_exchange_client.dart' as _i7;
import 'package:untitled4/data/network/internet_connection.dart' as _i5;
import 'package:untitled4/data/repository/exchange_repository_impl.dart'
    as _i11;
import 'package:untitled4/data/service/exchange_service.dart' as _i8;
import 'package:untitled4/data/service/exchange_service_impl.dart' as _i9;
import 'package:untitled4/domain/repository/exchange_repository.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.Dio>(() => appModule.dio);
    gh.factory<_i4.InternetConnection>(() => appModule.connectivity);
    gh.lazySingleton<_i5.InternetConnectionService>(
        () => _i5.InternetConnectionService(gh<_i4.InternetConnection>()));
    await gh.lazySingletonAsync<_i6.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i7.ApiExchangeClient>(
        () => _i7.ApiExchangeClient(gh<_i3.Dio>()));
    gh.lazySingleton<_i8.ExchangeService>(() => _i9.ExchangeServiceImpl(
          gh<_i7.ApiExchangeClient>(),
          gh<_i6.SharedPreferences>(),
          gh<_i5.InternetConnectionService>(),
        ));
    gh.lazySingleton<_i10.ExchangeRepository>(
        () => _i11.ExchangeRepositoryImpl(gh<_i8.ExchangeService>()));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}
