import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_mobile/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/repositories.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository: weatherRepository));
}
