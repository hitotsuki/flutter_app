import 'package:flutter/material.dart';
import 'package:flutter_app/main_model.dart';
import 'package:provider/provider.dart';

class LessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: Scaffold(
        appBar: AppBar(

          title: Text('練習用の画面'),
        ),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(
                  children: <Widget> [
                    Text(model.tukytext),
                    RaisedButton(
                        child: Text('ボタン'),
                        onPressed: () {
                          // 画面遷移の実装をいれる
                          model.ChangeTukyText();
                        },
                      ),
                  ]
              ),
            );
          }
        ),
      ),
    );
  }
}