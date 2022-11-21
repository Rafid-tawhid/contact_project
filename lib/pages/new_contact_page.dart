import 'dart:io';

import 'package:contact_project/pages/visiting_card_page.dart';
import 'package:contact_project/providers/contact_provider.dart';
import 'package:contact_project/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
import '../utils/constants.dart';

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
  String? _bloodGroup;
  late ContactProvider provider;


  @override
  void didChangeDependencies() {
    provider=Provider.of<ContactProvider>(context,listen: true);
    // final ContactModel contact=ModalRoute.of(context)!.settings.arguments as ContactModel;
    // if(contact!=null){
    //   setPropertyToField(contact);
    // }
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
      appBar: AppBar(title: Text('Add new Contact',style: TextStyle(fontSize: 15),),

        actions: [
         _isUploading?Padding(
           padding: const EdgeInsets.all(3.0),
           child: CircularProgressIndicator(
             color: Colors.white,
           ),
         ): Padding(
           padding: const EdgeInsets.only(right: 12.0),
           child: InkWell(
             onTap: _saveContact,
             child: Container(
               margin: EdgeInsets.only(top: 15,bottom: 15),
               padding: EdgeInsets.all(3),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(5)
               ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 5.0),
                       child: Text('Save ',style: TextStyle(color: Colors.green,fontSize: 12),),
                     ),
                     Icon(Icons.save,color: Colors.green,size: 18,),
                   ],
                 ),
             ),
           ),
         )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Visiting Card',
        backgroundColor: Colors.white,
        child: Text('Card',style: TextStyle(color: Colors.orange),),
        onPressed: () {
         // Navigator.pushNamed(context, VisitingCardPage.routeName);
        },
      ),
      body: Form(

        key: from_key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15,),
                      SizedBox(
                          height:80,width: 80,
                          child:ElevatedButton(
                            onPressed: (){},
                            child: Icon(Icons.add_a_photo_outlined,color: Colors.green,size: 35,),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: Colors.green,
                                    width: 1
                                  )
                                  //border radius equal to or more than 50% of width
                                )
                            ),
                          )
                      ),
                      SizedBox(height: 5,),
                      Text('Add Image',style: TextStyle(color: Colors.green,fontSize: 12),),
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
              TextFormField(
                controller: nameControler,
                decoration: InputDecoration(
                  labelText: 'Name',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.call),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.rate_review_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value){

                },

              ),
              SizedBox(height: 10,),
              TextFormField(

                controller: addressControler,
                decoration: InputDecoration(
                  labelText: 'Address',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.location_city),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value){

                },

              ),
              SizedBox(height: 10,),
              DropdownButtonFormField(
                hint: Text('Select Blood Group'),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  enabledBorder: OutlineInputBorder( //<-- SEE HERE
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder( //<-- SEE HERE
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _bloodGroup,
                onChanged: (value){
                  _bloodGroup=value;
                },
                items: bloodGroup.map((blood) =>
                    DropdownMenuItem(
                      child: Text(blood),
                      value: blood,
                    )
                ).toList(),
              ),
              SizedBox(height: 10,),
              Row(
            children: [
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      enabledBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
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
                  ),
                ],
              ),),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                      hint: Text('Select Zones'),

                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        enabledBorder: OutlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
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
                padding: const EdgeInsets.all(18.0),
                child: Text('Chose an Image',style: TextStyle(fontSize: 18),),
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
      EasyLoading.show();
      // context
      //     .read<ContactProvider>()
      //     .addNewContact(contact)
      //     .then((value) {
      //   nameControler.clear();
      //   Navigator.pop(context);
      // });
       await Provider
          .of<ContactProvider>(context, listen: false)
          .addNewContact(contact).then((value) {
            EasyLoading.dismiss();
            provider.contactList.clear();
            provider.getAllContacts();
            Navigator.pop(context);

      });


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

  void setPropertyToField(ContactModel contact) {
  setState(() {
    nameControler.text=contact.name!;
    designationControler.text=contact.designation!;
    addressControler.text=contact.address!;
    emailControler.text=contact.email!;
    numberControler.text=contact.number!;
  });
  }
}
