
import 'package:contact_project/pages/contact_details_page.dart';
import 'package:contact_project/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName='/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {



  @override
  void didChangeDependencies() {
   Provider.of<ContactProvider>(context,listen: true).
    getAllContacts();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact List'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
      ),

      body: ListView.builder(
        itemCount:contactList.length,
        itemBuilder: (context,index) =>
            ListTile(
              title: Text(contactList[index].name!),
              onTap: (){
                final contact=contactList[index];
                Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact);
              },
            ),
      ),
    );
  }
}
