import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Channel for chat with native",
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
      home: _MyChannelDemo(title: "Channel for chat with native"),
    );
  }
}

class _MyChannelDemo extends StatefulWidget {
  final String title;

  _MyChannelDemo({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyMethodChannelState();
//  State<StatefulWidget> createState() => _MyChannelState();
}

// BasicMessageChannel
class _MyChannelState extends State<_MyChannelDemo> {
  final TextEditingController _controller = new TextEditingController();

  // init
  static const BasicMessageChannel<String> _basicMessageChannel =
      BasicMessageChannel("BasicMessageChannelPlugin", StringCodec());

  String showMessage = "";
  String response = "";

  void _btnPressed() {
    // send
    handleBasicMessageChannelSend();
  }

  //send
  void handleBasicMessageChannelSend() async {
    response = await _basicMessageChannel.send(_controller.text);
    setState(() {
      showMessage = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: '传递给Native的数据',
              ),
            ),
          ),
          RaisedButton(
            onPressed: _btnPressed,
            child: Text("Msg To Native"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "来自native的消息：",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  showMessage,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    )

        //集成时打开
//      Center(
//        child: _widgetRoute(widget.initParams),
//      ),
        );
  }
}

// MethodChannel 调用 native 例子
// EventChannel
class _MyMethodChannelState extends State<_MyChannelDemo> {
  static const platform = const MethodChannel("app.channel.shared.data");
  static const _eventChannel = EventChannel("EventChannelPlugin");
  StreamSubscription streamSubscription;
  String _sharedText = "No data";

  // 调用 native
  void _getSharedText() async {
    var data = await platform.invokeMethod("getSharedText");
    if (data != null) {
      setState(() {
        _sharedText = data;
      });
    }
  }

  // receive
  void handleMethodChannelReceive() {
    Future<dynamic> platformCallHandler(MethodCall call) async {
      switch (call.method) {
        case "getPlatform":
//          return getPlatformName(); //调用success方法
          return PlatformException(code: '1002',message: "出现异常"); //调用error
          break;
      }
    }

    platform.setMethodCallHandler(platformCallHandler);
  }

  String getPlatformName() {
    if (Platform.isIOS) {
      return "iOS platform";
    } else if (Platform.isAndroid) {
      return "Android platform";
    }
    return "";
  }

  //receive
  void handleEventChannelReceive() {
    streamSubscription = _eventChannel
        .receiveBroadcastStream() //可以携带参数
        .listen(_onData, onError: _onError, onDone: _onDone);
  }

  void _onDone() {
    setState(() {
      _sharedText = "endOfStream";
    });
  }

  _onError(error) {
    setState(() {
      PlatformException platformException = error;
      _sharedText = platformException.message;
    });
  }

  void _onData(message) {
    setState(() {
      _sharedText = message;
    });
  }

  @override
  void dispose() {
    if (streamSubscription != null) {
      streamSubscription.cancel();
      streamSubscription = null;
    }
    super.dispose();
  }

  @override
  void initState() {
//    handleMethodChannelReceive();
    handleEventChannelReceive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Receiver text from native:',
          ),
          Text(
            '$_sharedText',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getSharedText,
        tooltip: '_getSharedText from native',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
