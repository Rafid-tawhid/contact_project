// import 'dart:io';
//
// import 'package:contact_project/models/contact_model.dart';
// import 'package:contact_project/pages/new_contact_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../providers/contact_provider.dart';
// import '../utils/constants.dart';
// List<String> _margeProperty=[];
//
// class VisitingCardPage extends StatefulWidget {
//   static const String routeName='/card';
//
//   const VisitingCardPage({Key? key}) : super(key: key);
//
//   @override
//   State<VisitingCardPage> createState() => _VisitingCardPageState();
// }
//
// class _VisitingCardPageState extends State<VisitingCardPage> {
//
//   String? _imageUrl;
//   List<String> scannedLines=[];
//   late ContactProvider provider;
//   ContactModel? _contactModel;
//   ImageSource _imageSource=ImageSource.camera;
//
//   @override
//   void didChangeDependencies() {
//
//     provider=Provider.of<ContactProvider>(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Take a Picture of Visiting Card'),
//         actions: [
//           TextButton(onPressed: (){
//             Navigator.pushNamed(context, NewContactPage.routeName,arguments: _contactModel);
//           }, child: Text('Next'))
//         ],
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Card(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: _imageUrl == null
//                     ? const Icon(
//                   Icons.photo,
//                   size: 200,
//                 )
//                     : Image.file(
//                 File(_imageUrl!),
//                   height: 200,
//                   width: 350,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: (){
//                     _imageSource=ImageSource.camera;
//                     _getImage();
//                   },
//                   child: Text('Camera')),
//               SizedBox(width: 20,),
//               ElevatedButton(
//                   onPressed: (){
//                     _imageSource=ImageSource.gallery;
//                     _getImage();
//                   },
//                   child: Text('Gallary')),
//
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: scannedLines.length,
//               itemBuilder: (context,index)=>LineItems(scannedLines[index]),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//             width: double.maxFinite,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 PropertyButton('Name'),
//                 PropertyButton('Designation'),
//                 PropertyButton('Phone'),
//                 PropertyButton('Email'),
//                 PropertyButton('Address'),
//               ],
//             ),
//           ),
//           SizedBox(height: 10,)
//         ],
//       ),
//     );
//   }
//   void _getImage() async {
//     List<String> liness=[];
//     final selectedImage = await ImagePicker().pickImage(source: _imageSource);
//     if (selectedImage != null) {
//       setState(() {
//         EasyLoading.show();
//         _imageUrl=selectedImage.path;
//       });
//
//
//       final textDetector=GoogleMlKit.vision.textRecognizer();
//       final inputImage=InputImage.fromFilePath(_imageUrl!);
//      final recognisedText= await textDetector.processImage(inputImage);
//      for(var i in recognisedText.blocks){
//        liness.add(i.text);
//      }
//
//      setState(() {
//        scannedLines= liness;
//        EasyLoading.dismiss();
//      });
//     }
//   }
//
//
//   Widget PropertyButton(String property){
//
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: ElevatedButton(
//           onPressed: (){
//             assignPropertyToContactModel(property);
//             ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//               content: Text('$property Added '),
//
//             ));
//           },
//           child: Text(property)),
//     );
//   }
//
//   void assignPropertyToContactModel(String property) {
//
//     final item=_margeProperty.join(' ');
//     switch(property){
//       case ContactProperty.name:
//         _contactModel!.name=item;
//         break;
//       case ContactProperty.email:
//         _contactModel!.email=item;
//         break;
//       case ContactProperty.designation:
//         _contactModel!.designation=item;
//         break;
//       case ContactProperty.phone:
//         _contactModel!.number=item;
//         break;
//       case ContactProperty.address:
//         _contactModel!.address =item;
//         break;
//     }
//     _margeProperty.clear();
//   }
// }
//
// class LineItems extends StatefulWidget {
//
//   final String lines;
//   LineItems(this.lines);
//
//   @override
//   State<LineItems> createState() => _LineItemsState();
// }
//
// class _LineItemsState extends State<LineItems> {
//   bool isChecked=false;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.lines),
//       trailing: Checkbox(
//         value: isChecked,
//         onChanged: (value){
//           setState(() {
//             isChecked=value!;
//           });
//           value!?_margeProperty.add(widget.lines):_margeProperty.remove(widget.lines);
//
//         },
//       ),
//     );
//   }
// }
