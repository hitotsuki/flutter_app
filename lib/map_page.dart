import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  MapPage(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('次の画面'),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.blue,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(name),
              Center(
                child: RaisedButton(
                  child: Text('前へ'),
                  onPressed: () {
                    // 画面遷移の実装をいれる
                    Navigator.pop(context, 'tsuky戻りました');
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}