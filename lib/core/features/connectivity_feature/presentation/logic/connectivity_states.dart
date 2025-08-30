part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityStates {}

class ConnectivityInit extends ConnectivityStates {}

class ConnectivityLoading extends ConnectivityStates {}

class ConnectivityConnected extends ConnectivityStates {}

class ConnectivityDisconnected extends ConnectivityStates {
  ConnectivityDisconnected();
}
