import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, fontFamily: "NotoSans SC"),
            ),
          ),
          Expanded(
            // width: double.infinity,
            // height: 300,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                // color: secondaryColor,
                child: Container(
                  child: Consumer<DataManager>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Text(value.allDataString);
                      // return ListView.builder(
                      //   // reverse: true,
                      //   // shrinkWrap: true,
                      //   // controller: ScrollController(
                      //   //     initialScrollOffset: 20 * (value.testList.length - 1)),
                      //   // dragStartBehavior: DragStartBehavior.down,
                      //   addAutomaticKeepAlives: true,
                      //   itemCount: value.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return value.testList[index];
                      //   },
                      //   // child: Consumer<Data>(
                      //   //   builder: (BuildContext context, value, Widget? child) {
                      //   //     return Text(rec += value.receivedData);
                      //   //   },
                      //   // ),
                      // );
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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, fontFamily: "NotoSans SC"),
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                    height: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '发送',
                        style: TextStyle(color: Colors.white, fontFamily: "NotoSans SC"),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)))),
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
