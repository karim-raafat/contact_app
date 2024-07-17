import 'package:contact_app/models/Contact.dart';
import 'package:contact_app/pages/contact_details.dart';
import 'package:contact_app/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  Contact contact;
  ContactView({super.key,required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(contact.name,style: TextStyle(fontSize: 18),),

            trailing: SizedBox(
              width: MediaQuery.of(context).size.width*0.16,
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.delete),onPressed: (){
                    Provider.of<AppProvider>(context,listen: false).deleteContact(context, contact);
                  },),
                  IconButton(icon: Icon(Icons.more_horiz),onPressed: (){
                    Provider.of<AppProvider>(context,listen: false).currentContact = contact;
                    context.goNamed(ContactDetailsPage.routeName);
                  },),
                ],
              ),
            ),
          ),
          Divider(thickness: 2,color: Colors.grey,)
        ],
      ),
    );
  }
}
