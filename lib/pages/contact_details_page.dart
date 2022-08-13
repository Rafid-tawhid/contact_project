import 'package:contact_project/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName='/details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late final contact;
  @override
  void didChangeDependencies() {
    contact=ModalRoute.of(context)!.settings.arguments as ContactModel;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Details'),),
      body: ListView(
        children: [
          Container(
            height: 100,
              width: 100,
              child:contact.image!=null? Image.network(contact.image):Image.asset('images/pc.jpg'))
          ,
          ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.email),
          )
        ],
      ),
    );
  }
}
