
import 'package:contact_project/pages/contact_details_page.dart';
import 'package:contact_project/pages/contactlist_page.dart';
import 'package:contact_project/pages/new_contact_page.dart';
import 'package:contact_project/pages/update_page.dart';
import 'package:contact_project/providers/contact_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      child: const MyApp(),
    providers: [
      ChangeNotifierProvider(create:(context)=>ContactProvider())
    ],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
     initialRoute: ContactListPage.routeName,
     routes: {
        ContactListPage.routeName:(context)=>ContactListPage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),
       UpdateContact.routeName:(context)=>UpdateContact(),
     },

    );
  }
}


