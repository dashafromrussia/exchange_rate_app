import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:untitled4/data/network/internet_connection.dart';
import 'package:untitled4/domain/repository/exchange_repository.dart';
import 'dart:async';
import 'package:untitled4/presentation/bloc/exchange_event.dart';
import 'package:untitled4/presentation/bloc/exchange_state.dart';
import 'package:untitled4/presentation/model/exchange_model.dart';


class ExchangeBloc extends Bloc<ExchangeEvent,ExchangeState>{

final ExchangeRepository _apiExchangeRepository;
final InternetConnectionService _internetConnection;
Map<String,dynamic> _rates = {};
ExchangeModel? _model;
StreamSubscription? _streamSubscription;
ExchangeBloc(this._apiExchangeRepository,this._internetConnection) : super(const BeginExchangeState()) {
  
    on<ExchangeEvent>((event,emit)async{
      if(event is GetAllDataExchangeEvent){
        if(_streamSubscription!=null){
      _streamSubscription =_internetConnection.isConnection.listen((InternetStatus event)async{
        if(event == InternetStatus.connected){
         try{
           _rates = await _apiExchangeRepository.getExchangeRateData();
           if(_model==null || _model?.firstValue==null){
             _rates = await _apiExchangeRepository.getExchangeRateData();
             _model = ExchangeModel(rates: _rates,
                 firstName: "EUR", secondName: "AED", firstValue: null, secondValue: null);
           }else{
             final double firstValue = _model!.firstValue!*_rates[_model?.firstValue]/_model!.rates[_model?.firstValue];
             _model = _model?.copyWith(firstValue:firstValue,
                 secondValue: firstValue* _rates[_model?.secondName]/_rates[_model?.firstName]);
             emit(SuccessDataExchangeState(exchangeModel:_model!));
           }
         }catch(e){
           emit(ErrorDataExchangeState());
         }
        }
      });
    }
        try{
          _rates = await _apiExchangeRepository.getExchangeRateData();
          _model = ExchangeModel(rates: _rates,
              firstName: "EUR", secondName: "AED", firstValue: null, secondValue: null);
          emit(SuccessDataExchangeState(exchangeModel:_model!));
        }catch(e){
          emit(ErrorDataExchangeState());
        }
       _rates = await _apiExchangeRepository.getExchangeRateData();
      }else if(event is ConvertFirstValueExchangeEvent){
        if(event.value==null){
          _model = _model?.copyWith(firstValue: null,secondValue: null);
        }else{
          _model = _model?.copyWith(firstValue: event.value,
              secondValue: event.value!*_model?.rates[_model?.secondName]/_model?.rates[_model?.firstName]);
        }
        emit(SuccessDataExchangeState(exchangeModel:_model!));
      }else if(event is ConvertSecondValueExchangeEvent){
        if(event.value==null){
          _model = _model?.copyWith(firstValue: null,secondValue: null);
        }else{
          _model = _model?.copyWith(secondValue: event.value,
              firstValue: event.value!*_model?.rates[_model?.firstName]/_model?.rates[_model?.secondName]);
        }
        emit(SuccessDataExchangeState(exchangeModel:_model!));
      }else if(event is ReverseValueExchangeEvent){
        if(_model?.secondValue==null){
          _model = _model?.copyWith(firstValue: null,secondValue: null,secondName: _model?.firstName,firstName: _model?.secondName);
        }else{
          _model = _model?.copyWith(firstValue: _model?.secondValue,
              secondValue: _model!.secondValue!*_model?.rates[_model?.firstName]/_model?.rates[_model?.secondName],
              secondName: _model?.firstName,firstName: _model?.secondName);
        }
        emit(SuccessDataExchangeState(exchangeModel:_model!));
      }else if(event is ChangeFirstCurrencyExchangeEvent){
        if(_model?.firstValue!=null){
          _model = _model?.copyWith(firstName: event.value,
              firstValue:_model!.firstValue!,
              secondValue: _model!.firstValue!*_model?.rates[_model?.secondName]/_model?.rates[event.value]);
        }else{
          _model = _model!.copyWith(firstName: event.value);
        }
        emit(SuccessDataExchangeState(exchangeModel:_model!));
      }else if(event is ChangeSecondCurrencyExchangeEvent){
        if(_model?.secondValue!=null){
          _model = _model?.copyWith(secondName: event.value,
              secondValue: _model!.secondValue!,
              firstValue: _model!.secondValue!*_model?.rates[_model?.firstName]/_model?.rates[event.value]);
        }else{
          _model = _model!.copyWith(secondName: event.value);
        }
        emit(SuccessDataExchangeState(exchangeModel:_model!));
      }
    });
 
  }

  @override
  Future<void> close() {
   _streamSubscription?.cancel();
    return super.close();
  }

}
