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
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.add_circle),
//                onPressed: _insert,
                tooltip: 'insert a new item',
              ),
              new IconButton(
                icon: const Icon(Icons.remove_circle),
//                onPressed: _remove,
                tooltip: 'remove the selected item',
              ),
            ],
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

class MainListWidget extends State<MainList>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  List<Item> items;

  @override
  void initState() {
    super.initState();
    items = List<Item>.generate(
        10, (i) => Item("标题 $i", "我今天吃饭了 $i", "18", "星期天", "12:12"));
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    animation = new Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          var distance = 0.0;
          var x = 0.0;
          var once = true;
          return GestureDetector(
            onTap: () {
              print("${item.title}");
            },
            onHorizontalDragStart: (details) {
              print("onStart");
              x = details.globalPosition.dx;
            },
            onHorizontalDragUpdate: (details) {
              distance = details.globalPosition.dx - x;
              if (distance > 100 && once) {
                print("Update = $distance");

                print("left 2 right");
                controller.forward();
                once = false;
                return;
              }

              if(distance < -100 && once) {
                print("Update = $distance");

                print("right 2 left");
                controller.reverse();
                once = false;
                return;
              }
            },
            onHorizontalDragEnd: (details) {
              print("onend");
              once = true;
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              padding: EdgeInsets.fromLTRB(
                  10.0, 10.0, animation.value.toDouble(), 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.blue)),
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
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _MyText(item.time, 12.0, Colors.blue[300], null),
                            Expanded(child: Text("")),
                            Icon(
                              Icons.ac_unit,
                              size: 16,
                              color: Colors.blue,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6.0),
                              child: Icon(
                                Icons.access_alarm,
                                size: 16,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        _MyText(item.title, 22.0, Colors.blue[600], null),
                        _MyText(item.content, 16.0, Colors.blue[300], null),
                      ],
                    ),
                  )),
                ],
              ),
              key: Key(item.title),
            ),
          );
        });
  }

  Widget _MyText(text, size, color, margin) {
    return Container(
      margin: margin,
      child: Text(text, style: TextStyle(color: color, fontSize: size)),
    );
  }
}
