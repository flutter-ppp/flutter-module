import 'package:flutter/material.dart';

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Layout showing",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _MyLayoutApp(title: "Layout showing"),
    );
  }
}

class _MyLayoutApp extends StatefulWidget {
  final String title;

  _MyLayoutApp({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<_MyLayoutApp> {
  String type = "row";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + "[$type]"),
      ),
      body: _getBody(type),
    );
  }

  Widget _getBody(String type) {
    switch(type){
      case "row":
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Row One', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Row Two', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Row Three', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Row Four', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        );
    }

    return Text("no body found");
  }
}
