import 'package:fluent_ui/fluent_ui.dart';
import 'package:serialport_tool/UI_components/ports_menu.dart';
import 'package:serialport_tool/UI_components/title_combo_menu.dart';
import 'package:serialport_tool/UI_components/connect_button.dart';
import 'package:serialport_tool/constants.dart';

// ignore: must_be_immutable
class ConfigBar extends StatelessWidget {
//   @override
//   State createState() {
//     return _ConfigBar();
//   }
// }
//
// class _ConfigBar extends State<ConfigBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 14, 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "基础",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              margin: EdgeInsets.only(bottom: 8),
            ),
            ConnectButton(),
            Container(
                // margin: EdgeInsets.fromLTRB(6, 2, 6, 8),
                margin: EdgeInsets.only(top: 8),
                height: 40,
                child: Text(
                  '设置',
                  style: subtitleTextStyle,
                )),
            PortsMenu(),
            TitleComboMenu(
              title: '波特率',
              items: baudRateMap.keys.toList(),
              defaultItem: '115200',
            ),
            TitleComboMenu(
              title: '数据位',
              items: dataBitsMap.keys.toList(),
              defaultItem: '8',
            ),
            TitleComboMenu(title: '校验位', items: parityMap.keys.toList()),
            TitleComboMenu(title: '停止位', items: stopBitsMap.keys.toList())
          ],
        ),
      ),
    );
  }
}
