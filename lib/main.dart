import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled4/data/network/internet_connection.dart';
import 'package:untitled4/injection.dart';
import 'package:untitled4/domain/repository/exchange_repository.dart';
import 'package:untitled4/presentation/bloc/exchange_bloc.dart';
import 'package:untitled4/presentation/bloc/exchange_event.dart';
import 'package:untitled4/presentation/bloc/exchange_state.dart';

//921fe7e8d2f54dc699059290fa445c03
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (BuildContext context) => ExchangeBloc(
              GetIt.instance<ExchangeRepository>(),
              GetIt.instance<InternetConnectionService>())
            ..add(GetAllDataExchangeEvent()),
          child: const MyHomePage(title: 'Exchange page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerFirstCurrency =
      TextEditingController();
  final TextEditingController _controllerSecondCurrency =
      TextEditingController();

  TextEditingController _setValueFirstController(double? value) {
    if (value == null) {
      _controllerFirstCurrency.text = '';
    } else {
      _controllerFirstCurrency.text = value.toString();
    }
    return _controllerFirstCurrency;
  }

  TextEditingController _setValueSecondController(double? value) {
    if (value == null) {
      _controllerSecondCurrency.text = '';
    } else {
      _controllerSecondCurrency.text = value.toString();
    }
    return _controllerSecondCurrency;
  }

  @override
  void dispose() {
    _controllerFirstCurrency.dispose();
    _controllerSecondCurrency.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child:
          BlocBuilder<ExchangeBloc, ExchangeState>(builder: (context, state) {
        return state is SuccessDataExchangeState
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _setValueFirstController(
                              state.exchangeModel.firstValue),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            if (v.endsWith(".") &&
                                state.exchangeModel.firstValue
                                        .toString()
                                        .length >
                                    v.length) {
                              context.read<ExchangeBloc>().add(
                                  const ConvertFirstValueExchangeEvent(
                                      value: null));
                            } else {
                              context.read<ExchangeBloc>().add(
                                  ConvertFirstValueExchangeEvent(
                                      value: double.tryParse(v)));
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: state.exchangeModel.firstName,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          context.read<ExchangeBloc>().add(
                              ChangeFirstCurrencyExchangeEvent(value: value!));
                        },
                        items: state.exchangeModel.rates.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ExchangeBloc>()
                          .add(const ReverseValueExchangeEvent());
                    },
                    child: const Text(
                      "⇵",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _setValueSecondController(
                              state.exchangeModel.secondValue),
                          keyboardType: TextInputType.number,
                          decoration:const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (v) {
                            if (v.endsWith(".") &&
                                state.exchangeModel.secondValue
                                        .toString()
                                        .length >
                                    v.length) {
                              context.read<ExchangeBloc>().add(
                                  const ConvertSecondValueExchangeEvent(
                                      value: null));
                            } else {
                              context.read<ExchangeBloc>().add(
                                  ConvertSecondValueExchangeEvent(
                                      value: double.tryParse(v)));
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: state.exchangeModel.secondName,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          context.read<ExchangeBloc>().add(
                              ChangeSecondCurrencyExchangeEvent(value: value!));
                        },
                        items: state.exchangeModel.rates.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ],
              )
            : state is BeginExchangeState? const Text("Загружаем данные...."):
        const Text('Извините,технические неполадки');
      })),
    );
  }
}
