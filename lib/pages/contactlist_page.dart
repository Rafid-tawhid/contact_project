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
          Navigator.pushNamed(context, NewContactPage.routeName);
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
                            Border.all(color: Colors.orange, width: 1)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            providers.contactList[index].image!,
                          ),
                          backgroundColor: Colors.orange,
                          radius: 30,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(providers.contactList[index].isFav=='0'?
                        Icons.favorite_border:Icons.favorite),
                        onPressed: () {
                          final contact= providers.contactList[index];
                          provider.updateContactToFavorite(contact);
                          setState(() {
                            selectedIndex=1;
                          });
                          // ArtSweetAlert.show(
                          //     context: context,
                          //     artDialogArgs: ArtDialogArgs(
                          //         confirmButtonText: 'Add',
                          //         cancelButtonText: 'Cancel',
                          //         type: ArtSweetAlertType.info,
                          //         title: "Add Favorite",
                          //         text: "Do you want to add ${providers.contactList[index].name} as Favorite",
                          //         onConfirm: (){
                          //           final contact= providers.contactList[index];
                          //           provider.updateContactToFavorite(contact);
                          //           print(contact.isFav);
                          //           Navigator.pop(context);
                          //         }
                          //     )
                          // );

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
          selectedItemColor: Colors.orange,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (value){
            setState(() {
              selectedIndex=value;
            });
            if(selectedIndex==0){
              provider.getAllContacts();

            }
            if(selectedIndex==1){
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
                    .startsWith(query.toLowerCase()) ||
                element.circle!.toLowerCase().startsWith(query.toLowerCase()) ||
                element.designation!
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
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
              border: Border.all(color: Colors.orange, width: 1)),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              suggestionList[index].image!,
            ),
            backgroundColor: Colors.orange,
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

