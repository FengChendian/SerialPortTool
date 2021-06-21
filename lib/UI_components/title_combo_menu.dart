import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class TitleComboMenu extends StatelessWidget {
  final String title;
  final String? defaultItem;
  final List<String> items;
  // final VoidCallback? onTap;
  // final bool dynamicUpdate;
  // final DataManager? dataManager;

  const TitleComboMenu({
    Key? key,
    required this.title,
    required this.items,
    // this.onTap,
    this.defaultItem,
    // this.dataManager,
    // this.dynamicUpdate = false,
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
      create: (_) => ComboMenuDataManager(
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(2),
                child: Consumer<ComboMenuDataManager>(
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
                    // underline: Container(
                    //   color: Colors.transparent,
                    // ),
                    onChanged: (value) {
                      // print(value);
                      // test(context);
                      if (value != null) {
                        combo.changeValue(value);
                      }
                      // if (value != null) setState(() => comboBoxValue = value);
                    },
                    // onTap: dynamicUpdate ?  (){
                    //   onTap!();
                    //   combo.changeValue(items[0]);
                    // } : null,
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

class ComboMenuDataManager with ChangeNotifier {
  late String? comboBoxValue;
  late List<String> items;

  ComboMenuDataManager({
    required this.comboBoxValue,
    required this.items,
  });
  ComboMenuDataManager.fromPorts({
    required this.items,
  }){
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
