import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../helpers/helper_methods.dart';
import '../../../../network/error_handling/custom_exception.dart';

part 'connectivity_states.dart';

@injectable
class ConnectivityCubit extends Cubit<ConnectivityStates> {
  // ConnectivityCubit() : super(ConnectivityInit());

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityCubit() : super(ConnectivityLoading()) {
    try {
      _subscription = _connectivity.onConnectivityChanged.listen((
        List<ConnectivityResult> result,
      ) {
        if (result.isEmpty || result[0] == ConnectivityResult.none) {
          emit(ConnectivityDisconnected());
        } else {
          emit(ConnectivityConnected());
        }
      });
    } on CustomException catch (e) {
      devLog('Failed to check connection: $e');
      emit(ConnectivityDisconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
