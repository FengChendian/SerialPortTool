import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:serialport_tool/constants.dart';
import 'package:win32/win32.dart';

class DataManager with ChangeNotifier {
  /// one instance has one [port]
  late SerialPort? port;

  String _receivedData = '';

  String get receivedData => _receivedData;

  String _allDataString = '';

  String get allDataString => _allDataString;

  late Timer _timer;

  List<String> portsList = [''];

  // String defaultValue = '';

  String _selectedPort = '';

  String get selectedPort => _selectedPort;

  late Uint8List _uInt8Data;

  int baudRate = CBR_115200;
  int byteSize = 8;
  int parity = NOPARITY;
  int stopBits = ONESTOPBIT;

  /// 设置选中时串口号时调用
  void updateSelectedPort(String value) {
    _selectedPort = value;
  }

  /// [start] read data
  void start() async {
    if (_selectedPort == '') {
      return;
    }
    port = SerialPort(_selectedPort, openNow: false);
    port!.openWithSettings(
      BaudRate: baudRate,
      ByteSize: byteSize,
      StopBits: stopBits,
      Parity: parity,
    );

    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) async {
      _uInt8Data = await port!.readBytes(1);
      if (_uInt8Data.isNotEmpty) {
        _receivedData = hex.encode(_uInt8Data).toUpperCase();
        _allDataString += _receivedData + ' ';
        notifyListeners();
      }
    });
  }

  void updateCommPorts() {
    portsList = SerialPort.getAvailablePorts();
    if (portsList.isEmpty) {
      portsList = [''];
    }
    updateSelectedPort(portsList[0]);
    notifyListeners();
  }

  void setDefaultPort(String value) {
    _selectedPort = value;
    notifyListeners();
  }

  void config(String title, String value) {
    switch (title) {
      case '波特率':
        baudRate = baudRateMap[value]!;
        break;
      case '数据位':
        byteSize = dataBitsMap[value]!;
        break;
      case '校验位':
        parity = parityMap[value]!;
        break;
      case '停止位':
        stopBits = stopBitsMap[value]!;
        break;
      default:
        throw Exception('no such config title');
    }
  }

  void stop() {
    /// cancel or close all things
    _timer.cancel();
    port!.close();
  }

  @override
  void dispose() {
    _timer.cancel();
    port!.close();

    super.dispose();
  }
}
