import 'package:fluent_ui/fluent_ui.dart';
import 'package:win32/win32.dart';

const baudRateMap = {
  '14400': CBR_14400,
  '19200': CBR_19200,
  '115200': CBR_115200,
  '128000': CBR_128000,
  '256000': CBR_256000,
};

const dataBitsMap = {
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
};

const parityMap = {
  'None': NOPARITY,
  'Even': EVENPARITY,
  'Odd': ODDPARITY,
  'Space': SPACEPARITY,
  'Mark': MARKPARITY,
};

const stopBitsMap = {
  '1': ONESTOPBIT,
  '1.5': ONE5STOPBITS,
  '2': TWOSTOPBITS,
};

const TextStyle subtitleTextStyle =
    TextStyle(fontSize: 20, fontFamily: "NotoSans SC");
