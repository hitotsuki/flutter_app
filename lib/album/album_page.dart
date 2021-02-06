import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_album/add_album_page.dart';
import 'package:flutter_app/domain/album.dart';
import 'package:provider/provider.dart';
import 'album_model.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlbumListModel>(
      create: (_) => AlbumListModel()..fetchAlbums(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('アルバム一覧'),
        ),
        body: Consumer<AlbumListModel>(
          builder: (context, model, child) {
            final albums = model.albums;
            final listTiles = albums
                .map(
                  (album) => ListTile(
                    leading: Image.network(album.imageURL),
                    title: Text(album.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        //todo
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAlbumPage(
                                album: album,
                              ),
                              fullscreenDialog: true,
                            ));
                        model.fetchAlbums();
                      },
                    ),
                    onLongPress: () async {
                      //todo 削除
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${album.title}を削除しますか？'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  //削除の動きを入れる
                                  await deleteAlbum(context, model, album);
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
            Consumer<AlbumListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAlbumPage(),
                    fullscreenDialog: true,
                  ));
              model.fetchAlbums();
            },
          );
        }),
      ),
    );
  }
}

Future deleteAlbum(
  BuildContext context,
  AlbumListModel model,
  Album album,
) async {
  try {
    await model.deleteAlbum(album);
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
    await model.fetchAlbums();
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
