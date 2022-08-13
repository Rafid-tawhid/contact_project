import 'package:contact_project/db/db_helper.dart';
import 'package:contact_project/pages/contactlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
import '../providers/contact_provider.dart';
import '../utils/helper_functions.dart';

class UpdateContact extends StatefulWidget {
  static const String routeName= '/update';
  const UpdateContact({Key? key}) : super(key: key);


  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  late ContactModel contact;
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
  bool setValuetoFields=true;

  final from_key=GlobalKey<FormState>();
  @override
  void dispose() {
    nameControler.dispose();
    numberControler.dispose();
    emailControler.dispose();
    addressControler.dispose();
    super.dispose();
  }


  @override
  void didChangeDependencies() {
    provider=Provider.of<ContactProvider>(context,listen: true);
    contact=ModalRoute.of(context)!.settings.arguments! as ContactModel;
    if(contact!=null){
      if(setValuetoFields){
        setContactInfo();
        setValuetoFields=false;
      }

    }
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Contact List'),

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Change Zone or Circle',style: TextStyle(color: Colors.red,fontSize: 16),),
            ),
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
                          items: circleList.map((circle) =>
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
                            items: zoneList.map((zones) =>
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
              child: Text('Change Image',style: TextStyle(color: Colors.red,fontSize: 16),),
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
                      ?  Image.network(
                    contact.image!,
                    height: 110,
                    width: 110,
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
      showMsg(context, 'Please select a date');
      return;
    }
    if(_imageUrl == null) {
      showMsg(context, 'Please select an image');
      return;
    }
    if(from_key.currentState!.validate()){
      final contactModel = ContactModel(
          id: contact.id!,
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

      // context
      //     .read<ContactProvider>()
      //     .updateProfile(contact.id!,contact.toMap())
    DbHelper.updateProfile(contact.id!, contactModel.toMap())
          .then((value) {
        nameControler.clear();
        Navigator.pushReplacementNamed(context, ContactListPage.routeName);
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

  void setContactInfo() {
    setState(() {
      nameControler.text=contact!.name!;
      emailControler.text=contact!.email!;
      designationControler.text=contact!.designation!;
      numberControler.text=contact!.number!;
      addressControler.text=contact!.address!;
      _zone=contact.zone;
      _circle=contact.circle;
      _dob=contact.doJoin;
    });
  }
}
