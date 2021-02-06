import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/album.dart';
import 'package:image_picker/image_picker.dart';

class AddAlbumModel extends ChangeNotifier {
  String albumTitle = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addAlbumToFirebase() async {
    if (albumTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    final imageURL = await _uploadImage();
    Firestore.instance.collection('albums').add(
      {
        'title': albumTitle,
        'imageURL': imageURL,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateAlbum(Album album) async {
    final document =
        Firestore.instance.collection('albums').document(album.documentID);
    final imageURL = await _uploadImage();
    await document.updateData(
      {
        'title': albumTitle,
        'imageURL': imageURL,
        'updateAt': Timestamp.now(),
      },
    );
  }

  setImage(File imageFile) {
    this.imageFile = imageFile;
    notifyListeners();
  }

  Future<String> _uploadImage() async {
    if (imageFile == null) {
      return '';
    }
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('albums').child(albumTitle);
    final snapshot = await ref
        .putFile(
          imageFile,
        )
        .onComplete;

    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
