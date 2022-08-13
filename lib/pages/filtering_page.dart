import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contact_provider.dart';

class FilteringPage extends StatefulWidget {
  static const String routeName='/filter';

  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  String? _zone;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   appBar: AppBar(title: Text('Zones & Circle'),),
    //   body: Consumer<ContactProvider>(
    //     builder: (context,provider,_)
    // =>StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    //         stream:provider.getFilteredContact(_zone!),
    //         builder: (context,snapshot){
    //           if(snapshot.hasData)
    //             {
    //              final contactModel=ContactModel.fromMap();
    //
    //
    //             }
    // }
    //
    //
    //
    //   ),
    // );
  }
}
