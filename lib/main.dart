import 'package:flutter/material.dart';
import 'package:flutter_app/album/album_page.dart';
import 'package:flutter_app/map_page.dart';
import 'package:flutter_app/question_page.dart';
import 'package:flutter_app/lesson_page.dart';
import 'package:flutter_app/book_list/book_list_page.dart';
import 'package:flutter_app/signup/signup_page.dart';

import 'login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo flutter-app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final myFocusNode = FocusNode();
  String name;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AlbumPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('問い合わせ'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionPage('ここは問い合わせページ')));
              },
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('練習'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LessonPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('メモ一覧'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookListPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('サインイン'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('ログイン'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
