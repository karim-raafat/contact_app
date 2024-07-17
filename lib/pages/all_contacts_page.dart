import 'package:contact_app/custom_widgets/contact_view.dart';
import 'package:contact_app/models/Contact.dart';
import 'package:contact_app/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AllContactsPage extends StatefulWidget {
  static final routeName = 'allContacts';

  const AllContactsPage({super.key});

  @override
  State<AllContactsPage> createState() => _AllContactsPageState();
}

class _AllContactsPageState extends State<AllContactsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: Colors.grey,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          ],
          backgroundColor: Colors.blue,
          title: Text(
            'My Contacts List',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Provider.of<AppProvider>(context, listen: false).getAllContacts();
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              builder: (context) => SafeArea(
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Contact',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextField(
                              controller: phoneNoController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                              ),
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email (optional)',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print(emailController.text);
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .addContact(
                                            context,
                                            nameController.text,
                                            phoneNoController.text,
                                            emailController.text);
                                    context.pop();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        body: Consumer<AppProvider>(
          builder:
              (BuildContext context, AppProvider appProvider, Widget? child) {
            print(appProvider.allContacts);
            return ListView.builder(
              itemCount: appProvider.allContacts.length,
              itemBuilder: (context,index) => ContactView(contact: appProvider.allContacts[index],),
            );
          },
        ));
  }
}
