import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' show Card;
import 'package:serialport_tool/constants.dart';
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

    return Container(
      margin: EdgeInsets.fromLTRB(8, 14, 14, 14),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            child: Text(
              '接收',
              // style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              style: subtitleTextStyle,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                // color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<DataManager>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Text(value.allDataString);
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            margin: EdgeInsets.only(top: 4),
            child: const Text(
              '发送',
              style: subtitleTextStyle,
            ),
          ),
          // Row(),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextBox(
                        placeholder: '发送数据',
                        // maxLines: null,
                        // decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                    height: double.infinity,
                    child: Button(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          '发送',
                          style: TextStyle( fontFamily: "NotoSans SC",),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
