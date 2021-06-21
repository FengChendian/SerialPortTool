import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:serialport_tool/data_manager.dart';

class ConnectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SideBarManager(),
      child: SizedBox(
        child: Consumer<SideBarManager>(
          builder: (_, sideBarManager, __) => Consumer<DataManager>(
            builder: (_, dataManager, __) => Row(
              children: [
                ToggleSwitch(
                  checked: sideBarManager.hasConnected,
                  // padding: EdgeInsets.symmetric(horizontal: 4),
                  onChanged: (v) {
                    sideBarManager.changeConnectState(v);
                    if (sideBarManager._hasConnected) {
                      dataManager.start();
                    } else {
                      dataManager.stop();
                    }
                  },
                ),
                Text(sideBarManager.connectText!, style: TextStyle(fontFamily: "NotoSans SC"),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SideBarManager with ChangeNotifier {
  // Color _connectButtonColor = Colors.red;

  bool _hasConnected = false;

  bool get hasConnected => _hasConnected;

  final _connectionTextMap = {true: "连接", false: "断开"};

  String? get connectText => _connectionTextMap[_hasConnected];

  // Color get connectButtonColor => _connectButtonColor;

  void changeConnectState(bool v) {
    _hasConnected = v;
    notifyListeners();
  }
}
