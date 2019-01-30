import 'package:flutter/material.dart';
import 'package:success/model/Item.dart';

class SuccessDailyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = "Success!";
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Scaffold(
            backgroundColor: Colors.blue[200],
            body: MainList(),
          )),
    );
  }
}

class MainList extends StatefulWidget {
  MainList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainListWidget();
}

class MainListWidget extends State<MainList> {
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.blue)),
            child: GestureDetector(
                onHorizontalDragStart: (detail) {},
                onHorizontalDragEnd: (detail) {},
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _MyText(item.day, 30.0, Colors.blue[300], null),
                        _MyText(item.week, 12.0, Colors.blue[300], null)
                      ],
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _MyText(item.time, 12.0, Colors.blue[300], null),
                          _MyText(item.title, 22.0, Colors.blue[600], null),
                          _MyText(item.content, 16.0, Colors.blue[300], null),
                        ],
                      ),
                    )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            color: Colors.blue,
                            onPressed: () {
                              SnackBar(content: Text("123"));
                            },
                            icon: Icon(Icons.adb),
                          ),
                          Icon(
                            Icons.ac_unit,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _MyText(text, size, color, margin) {
    return Container(
      margin: margin,
      child: Text(text, style: TextStyle(color: color, fontSize: size)),
    );
  }

  @override
  void initState() {
    super.initState();
    items = List<Item>.generate(
        10, (i) => Item("标题 $i", "我今天吃饭了 $i", "18", "星期天", "12:12"));
  }
}
