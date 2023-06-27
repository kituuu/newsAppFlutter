import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

import 'internet_event.dart';
import 'internet_state.dart';


// To check internet connectivity to decide whether to show news from hive or from news api
class InternetBloc extends Bloc<InternetEvent, InternetState> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
      on<InternetLostEvent>((event,emit) => emit(InternetLostState()));
      on<InternetGainEvent>((event, emit) => emit(InternetGainState()));

      connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
        if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
          add(InternetGainEvent());
        }
        else {
          add(InternetLostEvent());
        }
      });
    }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
