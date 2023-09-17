import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  // Necessary resources could be loaded here
  Future<Timer> loadFakeData() async {
    return Timer(const Duration(seconds: 5), _onDoneLoading);
  }

  void _onDoneLoading() {
    emit(SplashFakeDataLoaded());
  }
}
