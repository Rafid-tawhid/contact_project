import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';

List<ContactModel> contactList=[];
List<String> circleList=[];
List<String> zoneList=[];
final List<String> contactsName=[];
List<ContactModel> filteredContactList=[];

class ContactProvider extends ChangeNotifier {
  Future<void> addCategory(ContactModel contactModel) =>
      DbHelper.addNewContact(contactModel);

  getAllContacts() {
    DbHelper.getAllContacts().listen((event) {
      contactList = List.generate(event.docs.length, (index) =>
          ContactModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
    contactsName.clear();
    contactList.forEach((element) {
      contactsName.add(element.name!);
    });
  }

  getAllCircles() {
    DbHelper.getAllCircles().listen((snapshot) {
      circleList = List.generate(snapshot.docs.length, (index) =>
      snapshot.docs[index].data()['circle']);
      notifyListeners();
    });
  }

  getAllZones() {
    DbHelper.getAllZones().listen((snapshot) {
      zoneList = List.generate(snapshot.docs.length, (index) =>
      snapshot.docs[index].data()['zone']);
      notifyListeners();
    });
  }

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final photoRef = FirebaseStorage.instance.ref().child(
        'Pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return DbHelper.updateProfile(uid, map);
  }

  getFilteredContact(String zone) {
    DbHelper.getAllContactByFilteringZone(zone).listen((event) {
      filteredContactList = List.generate(event.docs.length, (index) =>
          ContactModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });

    print('SIZE OF FILTER ${filteredContactList.length}');
  }
}