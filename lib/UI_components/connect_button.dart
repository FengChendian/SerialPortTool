import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:serialport_tool/data_manager.dart';

class ConnectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<ConnectManager>(
        builder: (_, connectManager, __) => Consumer<DataManager>(
          builder: (_, dataManager, __) => Row(
            children: [
              ToggleSwitch(
                checked: connectManager.hasConnected,
                // padding: EdgeInsets.symmetric(horizontal: 4),
                onChanged: (v) {
                  if (dataManager.selectedPort == '') {
                    return;
                  }
                  connectManager.changeConnectState(v);
                  if (connectManager._hasConnected) {
                    dataManager.start();
                  } else {
                    dataManager.stop();
                  }
                },
              ),
              Text(
                connectManager.connectText!,
                style: TextStyle(fontFamily: "NotoSans SC"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectManager with ChangeNotifier {
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

  void disconnect(DataManager dataManager){
    _hasConnected = false;
    dataManager.stop();
    notifyListeners();
  }
}
