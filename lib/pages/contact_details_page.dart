import 'package:contact_project/models/contact_model.dart';
import 'package:contact_project/pages/new_contact_page.dart';
import 'package:contact_project/pages/update_page.dart';
import 'package:contact_project/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/drawer.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName='/details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late  ContactModel contact;
  bool isLogin = false;

  @override
  void didChangeDependencies() {
    contact = ModalRoute
        .of(context)!
        .settings
        .arguments as ContactModel;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
             // showTitleDialog();
               Navigator.pushNamed(context, UpdateContact.routeName,arguments: contact);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange, //color of border
                        width: 2, //width of border
                      ),
                    ),
                    child: contact.image != null ?
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(child: Image.network(
                        contact.image!, fit: BoxFit.fill, width: 100,)),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(child: Image.asset(
                        'images/pc.jpg', fit: BoxFit.fill, width: 100,)),
                    ),),
                  SizedBox(width: 20,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.name!, style: TextStyle(fontSize: 22,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),),
                      Text('Designation :${contact.designation!}', style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),),
                      Text('Zone :${contact.zone!}', style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),),
                      Text('Circle :${contact.circle!}', style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),),
                      Text('Address :${contact.address!}', style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [



                      Expanded(
                        child: Text('Number :', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),
                      ),

                      Expanded(
                        flex: 3,
                        child: Text(
                          contact.number!, style: TextStyle(fontSize: 20),),
                      )

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [


                      Text('Email :', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          contact.email!, style: TextStyle(fontSize: 20),),
                      )

                    ],
                  ),
                 SizedBox(height: 15,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     IconButton(onPressed: (){
                       makePhoneCall(contact.number!);
                     }, icon: Icon(Icons.call,size: 30,),),
                     IconButton(onPressed: (){
                       sendSms(contact.number!);

                     }, icon: Icon(Icons.message,size: 30,)),
                     IconButton(onPressed: (){
                       sendEmail(contact.email!);
                     }, icon: Icon(Icons.mail,size: 30,)),
                     SizedBox(width: 20,)
                   ],
                 )
                ],
              ),
            ),
          ),


          isLogin
              ? ElevatedButton(onPressed: () {}, child: Text('Edit'))
              : Text('')
        ],
      ),
    );
  }

  Future showTitleDialog() {
    Navigator.pushNamed(
        context, UpdateContact.routeName, arguments: contact);
    final adminCon = TextEditingController();
    final adminPass = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Admin Login'),
            icon: Icon(Icons.admin_panel_settings_outlined, color: Colors.red,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: adminCon,
                  decoration: InputDecoration(
                      hintText: ' Email',
                      contentPadding: const EdgeInsets.all(2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onChanged: (value) {
                    // do something
                  },
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: adminPass,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: ' Password',
                      contentPadding: const EdgeInsets.all(2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onChanged: (value) {
                    // do something
                  },
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    if (adminCon.text == 'admin' && adminPass.text == '123') {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, UpdateContact.routeName, arguments: contact);
                    }
                    else {
                      Navigator.pop(context);
                      showMsg(context, 'You are not an Admin');
                    }
                  },
                  child: Text('Login'),

                ),

              ],
            ),

          );
        });
  }




}
