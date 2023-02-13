import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  Future<void> _observe(
      NetworkObserve event, Emitter<NetworkState> emit) async {
    observeNetwork();
  }

  Future<void> _notifyStatus(
      NetworkNotify event, Emitter<NetworkState> emit) async {
    if (event.isConnected) {
      emit(NetworkSuccess());
    } else {
      emit(NetworkFailure());
    }
  }

  Future<void> observeNetwork() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        add(const NetworkNotify());
      } else {
        add(const NetworkNotify(isConnected: true));
      }
    });
  }
}
