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

List<Item> items;
int currentIndex;

class MainListWidget extends State<MainList> {

  @override
  void initState() {
    super.initState();
    items = List<Item>.generate(
        10, (i) => Item("标题 $i", "我今天吃饭了 $i", "18", "星期天", "12:12"));

    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemWidget(index);
        });
  }


}

class ItemWidgetState extends State<ItemWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  int index;
  Item item;

  ItemWidgetState(@required this.index);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = new Tween(begin: 10.0, end: 100.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    item = items[index];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var distance = 0.0;
    var x = 0.0;
    var once = true;
    return GestureDetector(
      onTap: () {
        print("${item.title}");
      },
      onHorizontalDragStart: (details) {
        x = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        distance = details.globalPosition.dx - x;
        if (distance > 100 && once) {
          controller.forward();
          currentIndex = index;
          once = false;
          return;
        }
      },
      onHorizontalDragEnd: (details) {
        once = true;
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
            currentIndex == index ? animation.value.toDouble() : 10.0,
            10.0,
            10.0,
            0.0),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
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
  }

  Widget _MyText(text, size, color, margin) {
    return Container(
      margin: margin,
      child: Text(text, style: TextStyle(color: color, fontSize: size)),
    );
  }
}

class ItemWidget extends StatefulWidget {

  int index;

  @override
  State<StatefulWidget> createState() {
    return ItemWidgetState(index);
  }

  ItemWidget(@required this.index);
}
