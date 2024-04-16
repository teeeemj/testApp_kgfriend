import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'check_internet_state.dart';

class InternetCubit extends Cubit<InternetStatus> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetCubit()
      : super(const InternetStatus(ConnectivityStatus.disconnected)) {
    trackConnectivityChange();
  }

  void trackConnectivityChange() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        _updateConnectivityStatus(results[0]);
      } else {
        _updateConnectivityStatus(ConnectivityResult.none);
      }
    });
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(const InternetStatus(ConnectivityStatus.disconnected));
    } else {
      emit(const InternetStatus(ConnectivityStatus.connected));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
