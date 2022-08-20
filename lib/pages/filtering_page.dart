import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contact_provider.dart';
import '../utils/helper_functions.dart';
import '../utils/search_field.dart';
import 'contact_details_page.dart';

class FilteringPage extends StatefulWidget {
  static const String routeName='/filter';

  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  String _zone='Zone 9';
  String query = '';
  late ContactProvider provider;
  final searchCont =TextEditingController();

 List<ContactModel> contact=[];


  @override
  void initState() {
    contact=contactList;
  }

  @override
  void didChangeDependencies() {
   provider=Provider.of<ContactProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contactList.length==0?Center(child: Text('No Data to Show.. \n Please add some data..')):
      SafeArea(
        child: Column(
          children: [
            
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount:contact.length,
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
                            subtitle: Text(contactList[index].circle!),
                            onTap: (){
                              final contact=contactList[index];
                              Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact);
                            },
                          ),
                        ),

                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  Widget buildSearch()=> SearchWidget(
    text: query,
    hintText:'Title or Name',
    onChanged: (String query) {
      final contact=contactList.where((element){
         final name=element.name!.toLowerCase();
         final circle=element.circle!.toLowerCase();
         final search=query.toLowerCase();

         return name.contains(search)||circle.contains(search);
       } ).toList();

       setState(() {
         this.query=query;
         this.contact=contact;
       });
    },
  );
}

