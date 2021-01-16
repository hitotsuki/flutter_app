import 'package:flutter/material.dart';
import 'package:flutter_app/next_page.dart';
import 'package:flutter_app/map_page.dart';
import 'package:flutter_app/question_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo flutter',
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
                  onTap: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage('mapページです'))
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Album'),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage('ここはAlbumページです'))
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('問い合わせ'),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionPage('ここは問い合わせページ'))
                    );
                  },
                ),
              ],
            ),
        ),
      );
  }
}
