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
      home: _MyLayoutApp(title: "Layout"),
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
  String type = "gridView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + "-$type"),
      ),
      body: _getBody(type),
    );
  }

  Widget _getBody(String type) {
    final methods = {
      "row": () {
        return _row();
      },
      "column": () {
        return _column();
      },
      "releativeLayout": () {
        return _relativeLayout();
      },
      "stack": () {
        return _stack();
      },
      "indexedStack": () {
        return _indexStack();
      },
      "gridView": () {
        return _gridView();
      }
    };

    return methods[type] != null ? methods[type]() : Text("no body");
  }

  Widget _gridView() {
    return Container(
      color: Colors.yellow,
      width: 10000000,
      height: 90000,
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection:Axis.horizontal,
        children: List.generate(
          100,
          (index) {
            return Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  child: Text('Item-$index',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )
                  )
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _indexStack() {
    return Container(
      color: Colors.yellow,
      child: IndexedStack(
        index: 1,
//        alignment: const Alignment(0.6, 0.6),
        alignment: const Alignment(0, 0),
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/pic.jpg'),
            radius: 100.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Mia B',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stack可以类比web中的absolute，绝对布局。绝对布局一般在移动端开发中用的较少，但是在某些场景下，还是有其作用
  Widget _stack() {
    return Stack(
//      alignment: AlignmentDirectional.bottomEnd,
      alignment: AlignmentDirectional(0, 0),
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/pic.jpg'),
          radius: 200.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Text(
            'Mia B',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _relativeLayout() {
    return new ListView(
      children: [
        new _Song(title: 'Trapadelic lobo', author: 'lillobobeats', likes: 4),
        new _Song(title: 'Different', author: 'younglowkey', likes: 23),
        new _Song(title: 'Future', author: 'younglowkey', likes: 2),
        new _Song(title: 'ASAP', author: 'tha_producer808', likes: 13),
        new _Song(title: '🌲🌲🌲', author: 'TraphousePeyton', likes: 1),
        new _Song(title: 'Something sweet...', author: '6ryan', likes: 5),
        new _Song(title: 'Sharpie', author: 'Fergie_6', likes: 10),
      ],
    );
  }

  Widget _column() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Column One'),
        Text('Column Two'),
        Text('Column Three'),
        Text('Column Four'),
      ],
    );
  }

  Widget _row() {
    return new Container(
        color: Colors.yellowAccent,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Icon(
              Icons.access_time,
              color: Colors.green,
              size: 50.0,
            ),
            new Icon(
              Icons.pie_chart,
              color: Colors.red,
              size: 100.0,
            ),
            new Icon(
              Icons.email,
              color: Colors.orange,
              size: 50.0,
            )
          ],
        ));
  }
}

class _Song extends StatelessWidget {
  const _Song({this.title, this.author, this.likes});

  final String title;
  final String author;
  final int likes;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade500.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: new IntrinsicHeight(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 10.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://xhbtest.oss-cn-hangzhou.aliyuncs.com/201909/c06d68fb-655a-4c4c-9c7b-ce5f25548d9b.jpg'),
                radius: 30.0,
              ),
            ),
            new Expanded(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(title, style: textTheme.subhead),
                    new Text(author, style: textTheme.caption),
                  ],
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Icon(Icons.play_arrow, size: 40.0),
                onTap: () {
                  print("arrow...");
                },
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.favorite, size: 24.0),
                    new Text('${likes ?? ''}'),
                  ],
                ),
                onTap: () {
                  print("like...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
