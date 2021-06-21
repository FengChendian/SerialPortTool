import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class DataManager with ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    // port.close();
    print('Did hot-reload');
  }

  late SerialPort? port;

  bool _running = false;

  bool get isRunning => _running;

  String _receivedData = '';

  String get receivedData => _receivedData;

  String _allDataString = '';

  String get allDataString => _allDataString;

  late Timer _timer;

  int length = 1;

  List<String> portsList = [''];

  String defaultValue = '';

  String _selectedPort = '';

  late Uint8List _uInt8Data;

  void updateSelectedPort(String value) {
    _selectedPort = value;
  }

  void start() async {
    port = SerialPort(_selectedPort);
    if (port!.isOpened == false) {
      port!.reopenPort();
    }
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      // _receivedData = String.fromCharCodes(await port!.readBytes(2));
      _uInt8Data = await port!.readBytes(1);
      if (_uInt8Data.isEmpty && _uInt8Data.any((element) => element == 0)) {
        return;
      }
      _receivedData = hex.encode(_uInt8Data).substring(0, 2).toUpperCase();
      length++;
      _allDataString += _receivedData + ' ';
      notifyListeners();
    });
  }

  void startReadLine() async {
    _running = true;
    // while (i++ < 100) {
    //   if (running == false) {
    //     return;
    //   }
    // print(port.readBytes(20));
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      _receivedData = String.fromCharCodes(await port!.readBytes(200));
      // _receivedData = "windows10 ";
      if (_receivedData.isNotEmpty &&
          receivedData.codeUnits.any((element) => element != 0)) {
        // test.add(Text(_receivedData));
        _allDataString += ' $_receivedData';
        // length++;
        // print('data: $_receivedData');
        notifyListeners();
      }
    });

    // notifyListeners();
    //   sleep(Duration(milliseconds: 500));
    // }
  }

  void updateCommPorts() {
    portsList = SerialPort.getAvailablePorts();
    if (portsList.isEmpty) {
      portsList = [''];
    }
    defaultValue = portsList[0];
    _selectedPort = defaultValue;
    notifyListeners();
  }

  void setDefaultPort(String value) {
    defaultValue = value;
    notifyListeners();
  }

  void stop() {
    _running = false;

    _timer.cancel();
    port!.close();
  }

  @override
  void dispose() {
    _timer.cancel();
    port!.close();

    super.dispose();
  }
// String data = '';
// Stream<String> get receivedData async*{
//   int i = 0;
//   while (i < 10){
//     // data += String.fromCharCodes(port.readBytes(20));
//     await Future.delayed(Duration(seconds: 1), () {
//       i++;
//     });
//     yield i.toString();
//   }
//
// }

// update() async{
//   _receivedData.add(String.fromCharCodes(port.readBytes(20)));
// }

// async{
//    // for(int i = 0; i < 10; i++){
//      _receivedData += String.fromCharCodes(port.readBytes(20));
//      // print(_receivedData);
//
//    // }
//
//  }
// void close() {
//   _receivedDataSubscription.cancel();
//   _receivedData.close();
// }
}
