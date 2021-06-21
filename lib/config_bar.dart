// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:serialport_tool/UI_components/ports_menu.dart';
import 'package:serialport_tool/UI_components/title_combo_menu.dart';
import 'package:serialport_tool/connect_button.dart';
import 'package:tuple/tuple.dart';
import 'UI_components/combo_menu.dart';
import 'data_manager.dart';

// ignore: must_be_immutable
class ConfigBar extends StatelessWidget {
//   @override
//   State createState() {
//     return _ConfigBar();
//   }
// }
//
// class _ConfigBar extends State<ConfigBar> {
  var baudRateList = ['115200', '9600'];
  var dataBitList = ['8', '10'];
  var checkBitList = ['None', '1'];

  var stopBitList = ['1', '2'];

  var comboBoxValue = 'CH340';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 4, 14, 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
              "基础",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            margin: EdgeInsets.only(bottom: 8),),
            ConnectButton(),
            Container(
                // margin: EdgeInsets.fromLTRB(6, 2, 6, 8),
              margin: EdgeInsets.only(top: 8),
                height: 40,
                child: Text(
                  '设置',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "NotoSans SC"),
                )),
            PortsMenu(),
            TitleComboMenu(title: '波特率', items: baudRateList),
            TitleComboMenu(title: '数据位', items: dataBitList),
            TitleComboMenu(title: '校验位', items: checkBitList),
            TitleComboMenu(title: '停止位', items: stopBitList)
          ],
        ),
      ),
    );
  }
}
