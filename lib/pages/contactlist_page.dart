import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:contact_project/models/contact_model.dart';
import 'package:contact_project/pages/contact_details_page.dart';
import 'package:contact_project/pages/filtering_page.dart';
import 'package:contact_project/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/drawer.dart';
import '../utils/helper_functions.dart';
import 'new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactModel? contactFinal;
  ContactModel? contactFinal2;
  ContactModel? demoContact;
  late ContactProvider provider;
  bool allContactCall = true;
  int selectedIndex=0;

  @override
  void didChangeDependencies() {
    provider = Provider.of<ContactProvider>(context, listen: false);
    provider.getAllCircles();
    provider.getAllZones();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Contact List'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, FilteringPage.routeName);
                showSearch(context: context, delegate: SearchContact())
                    .then((name) {
                  if (name != null) {
                    provider.contactList.forEach((element) {
                      if (element.name == name) {
                        contactFinal = element;
                      }
                    });
                    Navigator.pushNamed(context, ContactDetailsPage.routeName,
                        arguments: contactFinal);
                  }

                  //final newContact=contactList[int.parse(index!)];
                });
              },
              icon: Icon(Icons.search)),
              IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex=0;
                });
                Navigator.pushNamed(context, FilteringPage.routeName)
                    .then((circle) {
                  if(circle != null){
                    provider.getFilteredContactCircle(circle.toString());
                  }
                });
              },
              icon: Icon(Icons.filter_center_focus))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName,);
        },
      ),
      body: Consumer<ContactProvider>(
              builder: (context, providers, _) =>
                  ListView.builder(
                itemCount: providers.contactList.length,
                itemBuilder:(context, index) => provider.contactList.length == 0
                      ? Center(child: Text('No Data to Show.. \n Please add some data..')):
                     Column(
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Colors.green, width: 1)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            providers.contactList[index].image!,
                          ),
                          backgroundColor: Colors.green,
                          radius: 30,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(providers.contactList[index].isFav=='0'?
                        Icons.favorite_border:Icons.favorite,color: Colors.green,),
                        onPressed: () {
                          ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                  confirmButtonText: providers.contactList[index].isFav=='0'?'Add':'Remove',
                                  cancelButtonText: 'Cancel',
                                  showCancelBtn: true,
                                  onCancel: (){
                                    Navigator.pop(context);
                                  },
                                  type: ArtSweetAlertType.info,
                                  title: providers.contactList[index].isFav=='0'?"Add Favorite":"Remove Favorite",
                                  text: providers.contactList[index].isFav=='0' ?
                                  "Do you want to add ${providers.contactList[index].name} as Favorite":
                                  "Do you want to remove ${providers.contactList[index].name} from Favorite",
                                  onConfirm: (){
                                    final contact= providers.contactList[index];
                                    provider.contactList.clear();
                                    provider.updateContactToFavorite(contact).then((value){
                                      provider.getAllFavoriteContacts();
                                      setState(() {
                                        selectedIndex=1;
                                      });
                                      Navigator.pop(context);
                                    });

                                    // provider.contactList.clear();
                                    // provider.getAllContacts();

                                  }
                              )
                          );
                        },
                      ),
                      tileColor: Colors.white,
                      title: Text(
                          '${providers.contactList[index].name!}( ${provider.contactList[index].designation!} )'),
                      subtitle: Text(providers.contactList[index].circle!),
                      onTap: () {
                        final contact = providers.contactList[index];
                        Navigator.pushNamed(
                            context, ContactDetailsPage.routeName,
                            arguments: contact);
                      },
                      onLongPress: (){
                        final contact = providers.contactList[index];
                        ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                                confirmButtonText: 'OK',
                                cancelButtonText: 'Cancel',
                                type: ArtSweetAlertType.danger,
                                title: 'Delete Contact',
                                text: 'Do you really want to delete ${contact.name}',
                                onConfirm: (){
                                  provider.deleteContact(contact.id!).then((value){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${contact.name} deleted succesfully'))
                                    );
                                    provider.contactList.clear();
                                    provider.getAllContacts();
                                  });
                                  Navigator.pop(context);
                                }
                            )
                        );



                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),
                      height: .5,
                      color: Colors.grey.shade500,
                    )
                  ],
                ),
                  ),
            ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (value){
            setState(() {
              selectedIndex=value;
            });
            if(selectedIndex==0){
              provider.contactList.clear();
              provider.getAllContacts();
            }
            if(selectedIndex==1){
              provider.contactList.clear();
              provider.getAllFavoriteContacts();
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'All Contact'
            ),
            BottomNavigationBarItem(
                label: 'Favorite',
                icon: Icon(Icons.favorite),
            )

          ],
        ),

      ),
    );
  }

}

class SearchContact extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          // close(context,query);
          Navigator.pushNamed(context, ContactListPage.routeName);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: Center(child: Text('No Data Found')),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ContactProvider contactProvider;
    contactProvider = Provider.of<ContactProvider>(context);
    // final suggestionList = (query==null)? contactList:
    // contactList.where((contacts) =>
    //     contacts.name!.toLowerCase().startsWith(query.toLowerCase()) ||
    //         contacts.circle!.toLowerCase().startsWith(query.toLowerCase() )).toList();

    final suggestionList = (query == null)
        ? contactProvider.contactList2
        : contactProvider.contactList2.where((element) {
            return element.name!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                element.circle!.toLowerCase().contains(query.toLowerCase()) ||
                element.designation!
                    .toLowerCase()
                    .contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          final contact = suggestionList[index];
          Navigator.pushNamed(context, ContactDetailsPage.routeName,
              arguments: contact);
        },
        title: Text(suggestionList[index].name!),
        leading: Container(
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 1)),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              suggestionList[index].image!,
            ),
            backgroundColor: Colors.green,
            radius: 30,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.call,
            color: Colors.green,
          ),
          onPressed: () {
            makePhoneCall(suggestionList[index].number!);
          },
        ),
        subtitle: Text('Circle : ${suggestionList[index].circle!}'),
      ),
    );
  }
}

