import 'dart:io';

import 'package:contact_project/models/contact_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';

List<ContactModel> contactList=[];

class ContactProvider extends ChangeNotifier
{
  Future<void> addCategory(ContactModel contactModel) =>
      DbHelper.addNewContact(contactModel);

  getAllContacts() {
    DbHelper.getAllContacts().listen((event) {
      contactList = List.generate(event.docs.length, (index) =>
          ContactModel.fromMap(event.docs[index].data()));
      notifyListeners();

    });
  }

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}