import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_book/add_book_page.dart';
import 'package:flutter_app/book_list/book_list_model.dart';
import 'package:flutter_app/domain/book.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('メモ一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        //todo
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBookPage(
                                book: book,
                              ),
                              fullscreenDialog: true,
                            ));
                        model.fetchBooks();
                      },
                    ),
                    onLongPress: () async {
                      //todo 削除
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${book.title}を削除しますか？'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  //削除の動きを入れる
                                  await deleteBook(context, model, book);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookPage(),
                    fullscreenDialog: true,
                  ));
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }
}

Future deleteBook(
  BuildContext context,
  BookListModel model,
  Book book,
) async {
  try {
    await model.deleteBook(book);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('削除しました'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    Navigator.of(context).pop();
    await model.fetchBooks();
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
