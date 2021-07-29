import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:serialport_tool/constants.dart';
import 'package:win32/win32.dart';

class DataManager with ChangeNotifier {
  /// one instance has one [port]
  late SerialPort? port;

  String _receivedData = '';

  String get receivedData => _receivedData;

  // String _allDataString = '';
  //
  // String get allDataString => _allDataString;

  final receivedTextEditingController = TextEditingController();

  List<String> portsList = [''];

  // String defaultValue = '';

  String _selectedPort = '';

  String get selectedPort => _selectedPort;

  /// 存储接收到的Uint8数据
  late Uint8List _uInt8Data;

  int _baudRate = CBR_115200;
  int _byteSize = 8;
  int _parity = NOPARITY;
  int _stopBits = ONESTOPBIT;

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
      BaudRate: _baudRate,
      ByteSize: _byteSize,
      StopBits: _stopBits,
      Parity: _parity,
    );

    port!.readBytesOnListen(1, (value) {
      if (value.isNotEmpty) {
        _receivedData = hex.encode(value).toUpperCase();
        receivedTextEditingController.text += _receivedData + ' ';
        notifyListeners();
      }
    });

    // _timer = Timer.periodic(Duration(milliseconds: 20), (timer) async {
    //   _uInt8Data = await port!.readBytes(1);
    //   if (_uInt8Data.isNotEmpty) {
    //     _receivedData = hex.encode(_uInt8Data).toUpperCase();
    //     receivedTextEditingController.text += _receivedData + ' ';
    //     notifyListeners();
    //   }
    // });
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

  void transmitData(String data) {
    port!.writeBytesFromString(data);
    // notifyListeners();
  }

  void config(String title, String value) {
    switch (title) {
      case '波特率':
        _baudRate = baudRateMap[value]!;
        break;
      case '数据位':
        _byteSize = dataBitsMap[value]!;
        break;
      case '校验位':
        _parity = parityMap[value]!;
        break;
      case '停止位':
        _stopBits = stopBitsMap[value]!;
        break;
      default:
        throw Exception('no such config title');
    }
  }

  void stop() {
    /// cancel or close all things

    port!.close();
  }

  @override
  void dispose() {

    port!.close();

    super.dispose();
  }
}
