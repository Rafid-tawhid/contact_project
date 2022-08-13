import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';


class DbHelper {

  static const String collectionContact = 'Contacts';
  static const String collectionCircles = 'Circles';
  static const String collectionZones= 'Zones';



  static FirebaseFirestore _db = FirebaseFirestore.instance;



  static Future<void> addNewContact(ContactModel contactModel) {
    final doc = _db.collection(collectionContact).doc();
    contactModel.id = doc.id;
    print('Data ${contactModel.toString()}');
    return doc.set(contactModel.toMap());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllContacts() =>
      _db.collection(collectionContact).snapshots();


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

}