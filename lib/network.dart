import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetWorkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetWork App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NetWorkAppPage(),
    );
  }
}

class NetWorkAppPage extends StatefulWidget {
  NetWorkAppPage({Key key}) : super(key: key);

  @override
  _NetWorkAppPageState createState() => _NetWorkAppPageState();
}

class _NetWorkAppPageState extends State<NetWorkAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  showLoadingDialog() => widgets.length == 0;

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    }

    return getListView();
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  ListView getListView() => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: getBody(),
    );
  }

  Widget getRow(int i) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row isolate\n: ${widgets[i]["title"]}"));
  }

  loadData() async {
    final ReceivePort port = ReceivePort();
    await Isolate.spawn(dataLoader, port.sendPort);

    String dataURL = "https://jsonplaceholder.typicode.com/posts";

    // await
//    http.Response response = await http.get(dataURL);
//    setState(() {
//      widgets = json.decode(response.body);
//    });

    // isolate
    final SendPort sendPort = await port.first;
    List msg = await sendReceive(sendPort, dataURL);
    setState(() {
      widgets = msg;
    });
  }

  // The entry point for the isolate。 dataLoader() 就是运行在自己独立执行线程内的 Isolate
  static dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
