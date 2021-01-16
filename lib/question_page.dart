import 'package:flutter/material.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('次の画面'),
      ),
      body: Container(
        height: double.infinity,
        child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text('株式会社one wood'),
                      ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('mail address'),
                      ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('090-xxxx-xxxx'),
                ),
      ],
    ),
    ),
    );
  }
}