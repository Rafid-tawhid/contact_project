import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:contact_project/models/transfer_log_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';



class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList=[];
  List<ContactModel> contactList2=[];

  List<TransferLogModel> transferList=[];
  List<TransferLogModel> transferList2=[];

  List<String> circleList=[];
  List<String> zoneList=[];
  final List<String> contactsName=[];
  List<ContactModel> filteredContactList=[];
  List<ContactModel> filteredContactListCircle=[];


  Future<void> addNewContact(ContactModel contactModel) =>
      DbHelper.addNewContact(contactModel);

  Future<void> addTransferInfo(TransferLogModel transferLogModel) =>
      DbHelper.addTransferInfo(transferLogModel);

  getAllContacts() {
    contactList2.clear();
    contactList.clear();
    DbHelper.getAllContacts().listen((event) {
      for(var i in event.docs){
        contactList.add(ContactModel.fromMap(i.data()));
      }
      // contactList = List.generate(event.docs.length, (index) =>
      //     ContactModel.fromMap(event.docs[index].data()));
      contactList.sort((a, b) => a.name!.compareTo(b.name!));
      notifyListeners();
      contactList2.addAll(contactList);
      notifyListeners();
      print('getAllContacts ${contactList.length}');
    });

  }

  getAllTransferLog(String empId) {
    transferList2.clear();
    transferList.clear();
    DbHelper.getAlltransferHistory(empId).then((event) {
      for(var i in event.docs){
        transferList2.add(TransferLogModel.fromMap(i.data()));
      }
      //contactList.sort((a, b) => a.name!.compareTo(b.name!));
      transferList.addAll(transferList2);
      notifyListeners();
      print(transferList.first.empName);
    });

  }




  Future<void> updateContactToFavorite(ContactModel contact) async{
    contactList.clear();
    if(contact.isFav=='0'){
      contact.isFav='1';
      DbHelper.updateContactToFav(contact);
    }
    else{
      contact.isFav='0';
      DbHelper.updateContactToFav(contact);
    }

  }

  getAllFavoriteContacts() {
    contactList.clear();
    DbHelper.getAllFavContacts().listen((event) {
      contactList = List.generate(event.docs.length, (index) =>
          ContactModel.fromMap(event.docs[index].data()));
      notifyListeners();
      print('getAllFavoriteContacts ${contactList.length}');
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

  getFilteredContactCircle(String circle) {

    DbHelper.getAllContactByFilteringCircle(circle).listen((event) {
      contactList = List.generate(event.docs.length, (index) =>
          ContactModel.fromMap(event.docs[index].data()));
      print('SIZE OF FILTER ${contactList.length}');
      notifyListeners();
    });
  }

  Future<void> deleteContact(String id) {
    return DbHelper.deleteContact(id);
  }
}




// List<ContactModel> faw=[
//   ContactModel(id: '1',name: 'aaa'),
//   ContactModel(id: '1',name: 'bbb'),
//   ContactModel(id: '1',name: 'ccc'),
//   ContactModel(id: '1',name: 'ddd'),
//   ContactModel(id: '1',name: 'eee'),
//   ContactModel(id: '1',name: 'fff'),
//   ContactModel(id: '1',name: 'ggg'),
//   ContactModel(id: '1',name: 'hh'),
//   ContactModel(id: '1',name: 'ii'),
//   ContactModel(id: '1',name: 'jj'),
//   ContactModel(id: '1',name: 'kk'),
//   ContactModel(id: '1',name: 'll'),
//   ContactModel(id: '1',name: 'xx'),
//   ContactModel(id: '1',name: 'zz'),
//   ContactModel(id: '1',name: 'aaa'),
//   ContactModel(id: '1',name: 'bbb'),
//   ContactModel(id: '1',name: 'ccc'),
//   ContactModel(id: '1',name: 'ddd'),
//   ContactModel(id: '1',name: 'eee'),
//   ContactModel(id: '1',name: 'fff'),
//   ContactModel(id: '1',name: 'ggg'),
//   ContactModel(id: '1',name: 'hh'),
//   ContactModel(id: '1',name: 'ii'),
//   ContactModel(id: '1',name: 'jj'),
//   ContactModel(id: '1',name: 'kk'),
//   ContactModel(id: '1',name: 'll'),
//   ContactModel(id: '1',name: 'xx'),
//   ContactModel(id: '1',name: 'zz'),
//   ContactModel(id: '1',name: 'aaa'),
//   ContactModel(id: '1',name: 'bbb'),
//   ContactModel(id: '1',name: 'ccc'),
//   ContactModel(id: '1',name: 'ddd'),
//   ContactModel(id: '1',name: 'eee'),
//   ContactModel(id: '1',name: 'fff'),
//   ContactModel(id: '1',name: 'ggg'),
//   ContactModel(id: '1',name: 'hh'),
//   ContactModel(id: '1',name: 'ii'),
//   ContactModel(id: '1',name: 'jj'),
//   ContactModel(id: '1',name: 'kk'),
//   ContactModel(id: '1',name: 'll'),
//   ContactModel(id: '1',name: 'xx'),
//   ContactModel(id: '1',name: 'zz'),
//   ContactModel(id: '1',name: 'aaa'),
//   ContactModel(id: '1',name: 'bbb'),
//   ContactModel(id: '1',name: 'ccc'),
//   ContactModel(id: '1',name: 'ddd'),
//   ContactModel(id: '1',name: 'eee'),
//   ContactModel(id: '1',name: 'fff'),
//   ContactModel(id: '1',name: 'ggg'),
//   ContactModel(id: '1',name: 'hh'),
//   ContactModel(id: '1',name: 'ii'),
//   ContactModel(id: '1',name: 'jj'),
//   ContactModel(id: '1',name: 'kk'),
//   ContactModel(id: '1',name: 'll'),
//   ContactModel(id: '1',name: 'xx'),
//   ContactModel(id: '1',name: 'zz'),
// ];