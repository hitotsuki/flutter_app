import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage(this.name);
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
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Column(
              children: <Widget>[
                Icon(Icons.photo_album),
                Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ]
            );
          }),
        ),
        ),
      );
  }
}