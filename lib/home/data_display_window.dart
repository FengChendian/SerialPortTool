import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as md;
import 'package:provider/provider.dart';
import 'package:serialport_tool/data_manager.dart';

class DataDisplayWindow extends StatelessWidget {
  const DataDisplayWindow({Key? key}) : super(key: key);

//   @override
//   State createState() {
//     return _DataDisplayWindow();
//   }
// }
//
// class _DataDisplayWindow extends State<DataDisplayWindow>{

  @override
  Widget build(BuildContext context) {
    // ScrollController _controller = ScrollController();
    //
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   _controller.jumpTo(_controller.position.maxScrollExtent);
    // });
    final transmitTextEditingController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 40,
          //   child: Text(
          //     '接收',
          //     // style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          //     style: subtitleTextStyle,
          //   ),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              // padding: EdgeInsets.symmetric(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: md.ElevatedButton(
                          style: md.ButtonStyle(
                            elevation: md.MaterialStateProperty.all(1),
                            backgroundColor:
                                md.MaterialStateProperty.all(md.Colors.white),
                          ),
                          // style: ButtonStyle(
                          //     backgroundColor: ButtonState.all(Colors.white),
                          //     elevation: ButtonState.all(2),
                          //     shadowColor: ButtonState.all(Colors.transparent),
                          //     shape: ButtonState.all(RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(14)))),
                          onPressed: () {},
                          child: Text(
                            "Hex",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          // onTap: () {},
                        ),
                      ),
                      // Divider(
                      //   direction: Axis.vertical,
                      //   size: 20,
                      // )
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Consumer<DataManager>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Text(
                            value.receivedTextEditingController.text,
                            style: TextStyle(color: Colors.green),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Container(
          //   width: double.infinity,
          //   height: 40,
          //   margin: EdgeInsets.only(top: 4),
          //   child: const Text(
          //     '发送',
          //     style: subtitleTextStyle,
          //   ),
          // ),
          // Row(),
          Container(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Container(
                      // alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8),
                      child: TextBox(
                        controller: transmitTextEditingController,
                        placeholder: '发送数据',
                        textAlignVertical: TextAlignVertical.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // border: Border.all(width: 0),
                            color: Colors.white),
                        // maxLines: null,
                        // decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
                    height: double.infinity,
                    child: Consumer<DataManager>(
                      builder: (_, dataManager, __) => Button(
                        onPressed: () {
                          dataManager
                              .transmitData(transmitTextEditingController.text);
                          transmitTextEditingController.clear();
                        },
                        style: ButtonStyle(
                            backgroundColor: ButtonState.all(Colors.blue)),
                        child: Center(
                          child: Text(
                            '发送',
                            style: TextStyle(
                                fontFamily: "NotoSans SC", color: Colors.white),
                          ),
                        ),
                        // style: ButtonStyle(
                        //     backgroundColor:
                        //         MaterialStateProperty.all<Color>(Colors.blue),
                        //     shape: MaterialStateProperty.all(
                        //         RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8)))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
