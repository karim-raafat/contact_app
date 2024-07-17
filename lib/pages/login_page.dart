import 'package:contact_app/db/database.dart';
import 'package:contact_app/provider/app_provider.dart';
import 'package:contact_app/utils/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final routeName = '/';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController LoginEmailController = TextEditingController();
  TextEditingController SignEmailController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  TextEditingController SignPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Login or Sign up',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (value){
                  LoginEmailController.text = value;
                },
                controller: LoginEmailController,
                decoration: InputDecoration(

                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: LoginPasswordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child: TextButton(
                  onPressed: () {
                    appProvider.login(context, LoginEmailController.text, LoginPasswordController.text);
                    LoginEmailController.clear();
                    SignEmailController.clear();
                    LoginPasswordController.clear();
                    SignPasswordController.clear();
                    confirmPasswordController.clear();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )

                  ),
                  child: Text('Login',style: TextStyle(color: Colors.white),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(

                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'or create an account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF263238)),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),


                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                controller: SignEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: SignPasswordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.30,
                child: TextButton(
                  onPressed: () async {
                    if(confirmPasswordController.text != SignPasswordController.text){
                      showMsg(context, 'Passwords do not match');
                    }
                    else{
                      await appProvider.createUser(SignEmailController.text, SignPasswordController.text,context);
                      LoginEmailController.clear();
                      SignEmailController.clear();
                      LoginPasswordController.clear();
                      SignPasswordController.clear();
                      confirmPasswordController.clear();
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )

                  ),
                  child: Text('Create User',style: TextStyle(color: Colors.white),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
