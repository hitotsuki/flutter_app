import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/album.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'add_album_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddAlbumPage extends StatelessWidget {
  AddAlbumPage({this.album});
  final Album album;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = album != null;
    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = album.title;
    }

    return ChangeNotifierProvider<AddAlbumModel>(
      create: (_) => AddAlbumModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? 'アルバムを編集する' : 'アルバムを追加する'),
            ),
            body: Consumer<AddAlbumModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          // TODO: カメラロール開いて写真選ぶ
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          model.setImage(File(pickedFile.path));
                        },
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          child: model.imageFile != null
                              ? Image.file(model.imageFile)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      TextField(
                        controller: textEditingController,
                        onChanged: (text) {
                          model.albumTitle = text;
                        },
                      ),
                      RaisedButton(
                        child: Text(isUpdate ? '更新' : '追加'),
                        onPressed: () async {
                          model.startLoading();
                          if (isUpdate) {
                            await updateAlbum(model, context);
                          } else {
                            await addAlbum(model, context);
                          }
                          model.endLoading();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Consumer<AddAlbumModel>(
            builder: (context, model, child) {
              return model.isLoading
                  ? Container(
                      color: Colors.blue.withOpacity(0.8),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Future addAlbum(
    AddAlbumModel model,
    BuildContext context,
  ) async {
    try {
      await model.addAlbumToFirebase();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました'),
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

  Future updateAlbum(
    AddAlbumModel model,
    BuildContext context,
  ) async {
    try {
      await model.updateAlbum(album);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました'),
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
}
