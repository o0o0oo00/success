import 'package:flutter/material.dart';
import 'package:success/model/Item.dart';

class Detail extends StatelessWidget {
  Item item;

  Detail({this.item});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Detail",
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.white.withOpacity(0.5),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          title: null,
        ),
        body: DetailBodyStatus(item),
      ),
    );
  }
}

class DetailBodyStatus extends StatefulWidget {
  Item item;

  DetailBodyStatus(this.item);

  @override
  State<StatefulWidget> createState() {
    return DetailBody(item: item);
  }
}

class DetailBody extends State<DetailBodyStatus> {
  Item item;

  DetailBody({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.blue[200],
      child: Column(
        children: <Widget>[
          Text("{item.title}"),
          EditableText(
              controller: TextEditingController(),
              focusNode: FocusNode(),
              style: TextStyle(),
              cursorColor: Colors.blue),
          RichText(
            text: TextSpan(
              text: 'Hello ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: 'bold',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' world!'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
