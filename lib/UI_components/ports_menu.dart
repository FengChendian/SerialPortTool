import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show InkWell;
import 'package:provider/provider.dart';
import 'package:serialport_tool/UI_components/title_combo_menu.dart';
import 'package:serialport_tool/data_manager.dart';

class PortsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final a = context.select<DataManager, String>((value) => value.defaultValue);

    return Consumer<DataManager>(
      child: Text(
        '串口号:',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      builder: (_, dataManager, child) => ChangeNotifierProvider(
        create: (_) =>
            ComboMenuManager.fromPorts(items: dataManager.portsList),
        child: Consumer<ComboMenuManager>(
          builder: (_, combo, __) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              child!,
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        dataManager.updateCommPorts();
                        // context.read<DataManager>().updateCommPorts();
                        // combo.changeValue(context.read<DataManager>().defaultValue);
                        combo.changeValue(dataManager.selectedPort);
                        // combo.changeValue(a);
                      },
                      child: Container(
                        child: Icon(
                          Icons.refresh,
                        ),
                      )),
                  SizedBox(
                    width: 110,
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(2),
                      child: Combobox<String>(
                        // style: TextStyle(),
                        isExpanded: true,
                        // isDense: true,
                        items: dataManager.portsList
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
                            dataManager.updateSelectedPort(value);
                          }
                          // if (value != null) setState(() => comboBoxValue = value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
