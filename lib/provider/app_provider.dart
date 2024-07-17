import 'dart:convert';
import 'package:contact_app/pages/all_contacts_page.dart';
import 'package:contact_app/utils/helper_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/src/response.dart';
import 'package:go_router/go_router.dart';

import '../db/database.dart';
import '../models/Contact.dart';

class AppProvider extends ChangeNotifier{
  late int userID;
  List<Contact> allContacts = [];
  late Contact currentContact;

  Future<void> createUser(String email,String password,BuildContext context) async {
    if(email.contains('@') && email.contains('.com') && password != ''){
      Response response =  await create_User(email, password);
      switch (response.statusCode){
        case 201 : showMsg(context, 'User created Successfully! You can Login now'); break;
        case 400 : showMsg(context, 'Email already exists, try logging instead'); break;
      }
    }
    else {
      showMsg(context, 'Invalid Email');
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context, String email,String password) async {
    Response response = await loginUser(email,password);
    if(response.statusCode == 200){
      context.goNamed(AllContactsPage.routeName);
      Map<String,dynamic> data = jsonDecode(response.body);
      userID = data['id'];
      showMsg(context, data['status']);
    }
    else{
      showMsg(context, 'Invalid Email or Password');
    }
    await getAllContacts();
    notifyListeners();
  }
  Future<void> addContact (BuildContext context,String name, String phoneNo,String email) async{
    print(email);
    Response response = await add_Contact(name, phoneNo, email, userID);
    if(response.statusCode == 200){
      showMsg(context, response.body);
    }
    else{
      showMsg(context, response.body);
    }
    await getAllContacts();
    notifyListeners();
  }

  Future<void> deleteContact(BuildContext context,Contact contact) async{
    Response response = await delete_contact(contact.contactID);
    showMsg(context, 'Contact deleted Successfully');
    await getAllContacts();
    notifyListeners();
  }

  Future<void> getAllContacts() async{
    Response response = await get_all_contacts(userID);
    List<dynamic> respo =jsonDecode(response.body);
    allContacts = [];
    if(response.statusCode == 200){
      for (int i = 0; i<respo.length; i++){
        allContacts.add(Contact(contactID: respo[i][0] as int ,name: respo[i][1],email: respo[i][2], phoneNo: respo[i][3]));
      }
    }
  }
  Future<void> updateContact(BuildContext context,String name,String email,String phoneNo) async{
    Response response = await update_contact(name,email,phoneNo,currentContact.contactID);
    if(response.statusCode == 200){
      showMsg(context, response.body);
    }
    await getAllContacts();
    notifyListeners();
  }
}
