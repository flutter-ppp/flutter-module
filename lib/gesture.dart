import 'package:flutter/material.dart';

class GestureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gesture App",
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
      home: _MyGestureApp(title: "Gesture App"),
    );
  }
}

class _MyGestureApp extends StatefulWidget {
  final String title;

  _MyGestureApp({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyGestureState();
}

class _MyGestureState extends State<_MyGestureApp> {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();

//    controller = AnimationController( duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        child: RotationTransition(
            turns: curve,
            child: FlutterLogo(
              size: 200.0,
            )),
        onDoubleTap: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
      ),
    ));
  }
}
