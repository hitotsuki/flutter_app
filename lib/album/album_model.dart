import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/domain/album.dart';
import 'package:flutter_app/domain/book.dart';
import 'package:flutter/material.dart';

class AlbumListModel extends ChangeNotifier {
  List<Album> albums = [];

  Future fetchAlbums() async {
    final docs = await Firestore.instance.collection('albums').getDocuments();
    final albums = docs.documents.map((doc) => Album(doc)).toList();
    this.albums = albums;
    notifyListeners();
  }

  Future deleteAlbum(Album album) async {
    await Firestore.instance
        .collection('albums')
        .document(album.documentID)
        .delete();
  }
}
