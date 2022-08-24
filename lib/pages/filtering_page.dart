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

  //
  // @override
  // void initState() {
  //   contact=provider.contactList;
  // }

  @override
  void didChangeDependencies() {
   provider=Provider.of<ContactProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Circles'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 150
          ),
          children: provider.circleList.map((circleNo) =>InkWell(
            onTap: (){
              Navigator.pop(context,circleNo);

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                borderRadius: BorderRadius.circular(10)
              ),
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.height/3,
              child: Center(
                child: Text(circleNo,style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),
          )).toList(),
        ),
      ),
    );

  }

}

