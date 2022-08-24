import 'dart:io';

import 'package:contact_project/providers/contact_provider.dart';
import 'package:contact_project/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName='/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {

  final nameControler=TextEditingController();
  final numberControler=TextEditingController();
  final designationControler=TextEditingController();
  final emailControler=TextEditingController();
  final addressControler=TextEditingController();
  String? _dob;
  bool _isUploading = false;
  String? _imageUrl;
  ImageSource _imageSource=ImageSource.camera;
  String? _zone;
  String? _circle;
  late ContactProvider provider;


  @override
  void didChangeDependencies() {
    provider=Provider.of<ContactProvider>(context,listen: true);

    super.didChangeDependencies();
  }

  final from_key=GlobalKey<FormState>();
  @override
  void dispose() {
    nameControler.dispose();
    numberControler.dispose();
    designationControler.dispose();
    emailControler.dispose();
    addressControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact List'),

        actions: [
         _isUploading?Padding(
           padding: const EdgeInsets.all(3.0),
           child: CircularProgressIndicator(
             color: Colors.white,
           ),
         ): IconButton(onPressed: _saveContact, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: from_key,
        child: ListView(
          children: [
            TextFormField(
              controller: nameControler,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'This field must not be empty';
                }
                if(value.length>20){
                  return 'Name must be in 20 carecter';
                }
                else {
                  return null;
                }
              },

            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: numberControler,
              decoration: InputDecoration(
                labelText: 'Number',
                prefixIcon: Icon(Icons.call),
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'This field must not be empty';
                }
                if(value.length>20){
                  return 'Name must be in 20 carecter';
                }
                else {
                  return null;
                }
              },

            ),

            SizedBox(height: 10,),
            TextFormField(
              controller: designationControler,
              decoration: InputDecoration(
                labelText: 'Designation',
                prefixIcon: Icon(Icons.rate_review_outlined),
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'This field must not be empty';
                }
                else {
                  return null;
                }
              },

            ),

            SizedBox(height: 10,),
            TextFormField(
              controller: emailControler,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value){

              },

            ),
            SizedBox(height: 10,),
            TextFormField(

              controller: addressControler,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_city),
              ),
              validator: (value){

              },

            ),
            SizedBox(height: 10,),

        Row(
          children: [
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:DropdownButtonFormField(
                    hint: Text('Select Circle'),
                    value: _circle,
                    onChanged: (value){
                      _circle=value;
                    },
                    items: provider.circleList.map((circle) =>
                        DropdownMenuItem(
                            child: Text(circle),
                          value: circle,
                        )
                    ).toList(),
                  )
                ),
              ],
            ),),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:DropdownButtonFormField(
                        hint: Text('Select Zones'),
                        value: _zone,
                        onChanged: (value){
                          _zone=value;
                        },
                        items: provider.zoneList.map((zones) =>
                            DropdownMenuItem(
                              child: Text(zones),
                              value: zones,
                            )
                        ).toList(),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),

            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectDate,
                      child: Text('Select Joining Date')),

                  Text(_dob==null?'No Date Chosen':_dob!),
                ],
              ),
            ), //date of birth

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Chose an Image'),
            ),
            Center(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: _imageUrl == null
                      ? const Icon(
                    Icons.photo,
                    size: 110,
                  )
                      : Image.network(
                    _imageUrl!,
                    height: 110,
                    width: 110,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      _imageSource=ImageSource.camera;
                      _getImage();
                    },
                    child: Text('Camera')),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: (){
                      _imageSource=ImageSource.gallery;
                      _getImage();
                    },
                    child: Text('Gallary')),

              ],
            )


          ],
        ),
      ),
    );
  }
  void _saveContact() async {
    if(_dob == null) {
      showMsg(context, 'Please select a purchase date');
      return;
    }
    if(_imageUrl == null) {
      showMsg(context, 'Please select an image');
      return;
    }
    if(from_key.currentState!.validate()){
      final contact = ContactModel(
          name: nameControler.text,
          number: numberControler.text,
          designation: designationControler.text,
          email: emailControler.text,
          address: addressControler.text,
          doJoin: _dob,
          zone: _zone,
          circle: _circle,
          image: _imageUrl
      );
       print(contact.toString());
      context
          .read<ContactProvider>()
          .addCategory(contact)
          .then((value) {
        nameControler.clear();
        Navigator.pop(context);
      });
      // final status = await Provider
      //     .of<ContactProvider>(context, listen: false)
      //     .addNewContact(contact);
      // if(status){
      //   Navigator.pop(context);
      // }
    }
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if(selectedDate!=null){
      setState((){
        _dob=DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _isUploading = true;
      });
      try {
        final url =
        await context.read<ContactProvider>().updateImage(selectedImage);
        setState(() {
          _imageUrl = url;
          _isUploading = false;
        });
      } catch (e) {}
    }
  }
}
