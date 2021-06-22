import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:serialport_tool/data_manager.dart';

class TitleComboMenu extends StatelessWidget {
  final String title;
  final String? defaultItem;
  final List<String> items;

  const TitleComboMenu({
    Key? key,
    required this.title,
    required this.items,
    this.defaultItem,
  }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _TitleComboMenu(title, items, onTap, defaultItem);
//   }
// }
//
// class _TitleComboMenu extends State<TitleComboMenu> {
//   final String title;
//   final String? defaultItem;
//   final List<String> items;
//   final VoidCallback? onTap;
//
//   _TitleComboMenu(this.title, this.items, this.onTap, this.defaultItem);
//
//   var comboBoxValue;
//
//   @override
//   void initState() {
//     super.initState();
//     comboBoxValue = defaultItem ?? items[0];
//   }

  //
  //   @override
  // void dispose() {
  //   super.dispose();
  // }

  // if (items.isNotEmpty) {
  // comboBoxValue = items[0];
  // } else {
  // comboBoxValue = '';
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComboMenuManager(
          comboBoxValue: defaultItem ?? items[0], items: items),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 110,
              child: Consumer<DataManager>(
                builder: (_, dataManager, __) => Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(2),
                  child: Consumer<ComboMenuManager>(
                    builder: (_, combo, __) => Combobox<String>(
                      // style: TextStyle(),
                      isExpanded: true,
                      // isDense: true,
                      items: items
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: combo.comboBoxValue,
                      onChanged: (value) {
                        if (value != null) {
                          combo.changeValue(value);
                          dataManager.config(title, value);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComboMenuManager with ChangeNotifier {
  late String? comboBoxValue;
  late List<String> items;

  ComboMenuManager({
    required this.comboBoxValue,
    required this.items,
  });

  ComboMenuManager.fromPorts({
    required this.items,
  }) {
    comboBoxValue = items[0];
  }

  changeValue(String value) {
    comboBoxValue = value;
    notifyListeners();
  }

  updatePorts() {
    items = SerialPort.getAvailablePorts();
    if (items.isEmpty) {
      items = [''];
      comboBoxValue = '';
    } else {
      comboBoxValue = items[0];
    }

    notifyListeners();
  }
}
