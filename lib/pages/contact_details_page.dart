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
  late final ContactModel contact;
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
              showTitleDialog();
              // Navigator.pushNamed(context, UpdateContact.routeName,arguments: contact);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Align(
              alignment: Alignment.center,
              child: Text(contact.name!, style: TextStyle(fontSize: 30,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),)),
          SizedBox(height: 20,),
          Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100)
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
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 10,),
                  Text('Name :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(contact.name!, style: TextStyle(fontSize: 20),),
                  )

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.numbers),
                  ),
                  SizedBox(width: 10,),
                  Text('Number :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      _makePhoneCall(contact.number!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        contact.number!, style: TextStyle(fontSize: 20),),
                    ),
                  )

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.email),
                  ),
                  SizedBox(width: 10,),
                  const Text('Email :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      sendEmail(contact.email!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        contact.email!, style: TextStyle(fontSize: 20),),
                    ),
                  )

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.home),
                  ),
                  SizedBox(width: 10,),
                  const Text('Address :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      contact.address!, style: TextStyle(fontSize: 20),),
                  ),


                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.home),
                  ),
                  SizedBox(width: 10,),
                  const Text('Circle :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      contact.circle!, style: TextStyle(fontSize: 20),),
                  ),


                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.home),
                  ),
                  SizedBox(width: 10,),
                  const Text('Zone :', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(contact.zone!, style: TextStyle(fontSize: 20),),
                  ),


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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void sendEmail( String emails) async{
    String email = Uri.encodeComponent(emails);
    String subject = Uri.encodeComponent("Hello");
    String body = Uri.encodeComponent("Good Morning");
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
    //email app opened
    }else{
    //email app is not opened
    }
  }


}
