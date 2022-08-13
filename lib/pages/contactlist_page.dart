
import 'dart:ffi';

import 'package:contact_project/models/contact_model.dart';
import 'package:contact_project/pages/contact_details_page.dart';
import 'package:contact_project/pages/filtering_page.dart';
import 'package:contact_project/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/drawer.dart';
import '../utils/helper_functions.dart';
import 'new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName='/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

  ContactModel? contactFinal;


  @override
  void didChangeDependencies() {
   Provider.of<ContactProvider>(context,listen: true).
    getAllContacts();
   Provider.of<ContactProvider>(context,listen: false).
   getAllCircles();
   Provider.of<ContactProvider>(context,listen: false).getAllZones();
  
   Provider.of<ContactProvider>(context,listen: false).
   getFilteredContact('Zone 9');

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('Contact List'),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: SearchContact()).then((name){
              contactList.forEach((element) {
                if(element.name==name){
                  contactFinal=element;
                }
              });
              //final newContact=contactList[int.parse(index!)];
              Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contactFinal);
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, FilteringPage.routeName);
          }, icon: Icon(Icons.filter_center_focus))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
      ),

      body: contactList.length==0?Center(child: Text('No Data to Show.. \n Please add some data..')): ListView.builder(
        itemCount:contactList.length,
        itemBuilder: (context,index) =>
            Column(
              children: [
                Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Container(
                      decoration:new BoxDecoration(
                          shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 1
                        )
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          contactList[index].image!,
                        ),
                        backgroundColor: Colors.orange,
                        radius: 30,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.call,color: Colors.green,),
                      onPressed: (){
                        makePhoneCall(contactList[index].number!);
                      },
                    ),
                    tileColor: Colors.white,
                    title: Text('${contactList[index].name!}( ${contactList[index].designation!} )'),
                    subtitle: Text(contactList[index].zone!),
                    onTap: (){
                      final contact=contactList[index];
                      Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact);
                    },
                  ),
                ),

              ],
            ),
      ),
    );
  }
}
class SearchContact extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){

        query='';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, '');
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: Center(child: Text('No Data Found')),
      // leading: Icon(Icons.search),
      // onTap: (){
      //   close(context, query);
      // },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = (query==null)? contactsName:
    contactsName.where((contacts) =>
        contacts.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index)=>ListTile(
        onTap: (){

          close(context, suggestionList[index]);
        },
        title: Text(suggestionList[index]),
      ),
    );
  }
  
}
