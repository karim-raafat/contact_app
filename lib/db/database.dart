import 'dart:convert';
import 'package:contact_app/models/Contact.dart';
import 'package:http/http.dart' as http;

Future<http.Response> create_User(String email, String password) async {
  final url = Uri.parse('http://127.0.0.1:5000/users');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );
  return response;
}

Future<http.Response> loginUser(String email, String password) async {
  final url = Uri.parse(
      'http://127.0.0.1:5000/users?email=${email}&password=${password}');
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  return response;
}

Future<http.Response> add_Contact(
    String name, String phoneNo, String email, int userID) async {
  final url = Uri.parse('http://127.0.0.1:5000/contacts');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'phoneNo': phoneNo,
        'email': email,
        'userID': userID
      }));
  print('pass');
  return response;
}

Future<http.Response> get_all_contacts(int userID) async {
  final url = Uri.parse('http://127.0.0.1:5000/contacts/$userID');
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  return response;
}

Future<http.Response> delete_contact(int contactID) async {
  final url = Uri.parse('http://127.0.0.1:5000/contacts/$contactID');
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  return response;
}

Future<http.Response> update_contact(
    String name, String email, String phoneNo, int contactID) async {
  final url = Uri.parse('http://127.0.0.1:5000/contacts/$contactID');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name,'phoneNo' : phoneNo, 'email' : email}),
  );
  return response;
}
