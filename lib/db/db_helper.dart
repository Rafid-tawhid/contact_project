import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:contact_project/models/transfer_log_model.dart';


class DbHelper {

  static const String collectionContact = 'Contacts';
  static const String collectionCircles = 'Circles';
  static const String collectionZones= 'Zones';
  static const String collectionTransferLog= 'TransferLog';



  static FirebaseFirestore _db = FirebaseFirestore.instance;


 static Future<void> deleteContact(String id ){
   return _db.collection(collectionContact).doc(id).delete();
  }

  static Future<void> addNewContact(ContactModel contactModel) {
    final doc = _db.collection(collectionContact).doc();
    contactModel.id = doc.id;
    print('Data ${contactModel.toString()}');
    return doc.set(contactModel.toMap());
  }
  static Future<void> addTransferInfo(TransferLogModel transferLogModel) {
    final doc = _db.collection(collectionTransferLog).doc();
    transferLogModel.id = doc.id;
    print('Data ${transferLogModel.toString()}');
    return doc.set(transferLogModel.toMap());
  }

  static Future<void> updateContactToFav(ContactModel contactModel) {
    final doc = _db.collection(collectionContact).doc(contactModel.id);
    return doc.update(contactModel.toMap());
  }


    static Stream<QuerySnapshot<Map<String, dynamic>>> getAllContacts() =>
      _db.collection(collectionContact).snapshots();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAlltransferHistory(String empId) =>
      _db.collection(collectionTransferLog).where('emp_id',isEqualTo:empId).get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFavContacts() =>
      _db.collection(collectionContact).where('isFav',isEqualTo:'1',).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllZones() =>
      _db.collection(collectionZones).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCircles() =>
      _db.collection(collectionCircles).snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {

    return _db.collection(collectionContact).doc(uid).update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllContactByFilteringZone(String zone){

    return _db.collection(collectionContact).
    where('zone',isEqualTo: zone).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllContactByFilteringCircle(String circle){

    return _db.collection(collectionContact).
    where('circle',isEqualTo: circle).snapshots();
  }



}