import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';


class DbHelper {

  static const String collectionContact = 'Contacts';


  static FirebaseFirestore _db = FirebaseFirestore.instance;



  static Future<void> addNewContact(ContactModel contactModel) {
    final doc = _db.collection(collectionContact).doc();
    contactModel.id = doc.id;
    print('Data ${contactModel.toString()}');
    return doc.set(contactModel.toMap());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllContacts() =>
      _db.collection(collectionContact).snapshots();


}