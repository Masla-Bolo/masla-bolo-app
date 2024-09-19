// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';

// class NetworkListener {
//   NetworkListener() {
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

//   Future<void> start() async {
//     late List<ConnectivityResult> result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       return;
//     }
//     return _updateConnectionStatus(result);
//   }

//   Future<void> stop() async {
//     await _connectivitySubscription.cancel();
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     final networkType = () {
//       switch (result.first) {
//         case ConnectivityResult.wifi:
//         // return NetworkTypePB.Wifi;
//         case ConnectivityResult.ethernet:
//         // return NetworkTypePB.Ethernet;
//         case ConnectivityResult.mobile:
//         // return NetworkTypePB.Cell;
//         case ConnectivityResult.bluetooth:
//         // return NetworkTypePB.Bluetooth;
//         case ConnectivityResult.vpn:
//         // return NetworkTypePB.VPN;
//         case ConnectivityResult.none:
//         case ConnectivityResult.other:
//         // return NetworkTypePB.NetworkUnknown;
//       }
//     }();
//     final state = NetworkStatePB.create()..ty = networkType;
//     return UserEventUpdateNetworkState(state).send().then((result) {
//       result.fold((l) {}, (e) => Log.error(e));
//     });
//   }
// }
