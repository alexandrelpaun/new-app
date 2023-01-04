import 'package:auto_sales_flutter/cars/anunturi_masini.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:auto_sales_flutter/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); 
    }



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        
        key: _formKey,
        child: ListView(
          
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            TextFormField(
              textAlign: TextAlign.center,
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Pasword',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password!';
                } else if (value != confPasswordController.text) {
                  return 'Both pass should be the same!';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              textAlign: TextAlign.center,
              obscureText: true,
              controller: confPasswordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: 'Confirm Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                } else if (value != passwordController.text) {
                  return 'Both pass should be the same!';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 50.0),
            TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80.0))),
                ),
                validator: (value) {
                  if (value != null && !EmailValidator.validate(value)) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
                }),
            const SizedBox(height: 50.0),
            Container(
              margin: EdgeInsets.all(80),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(
                        '${emailController.text} - ${passwordController.text} - ${confPasswordController.text}');


                        

                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);

                    if (newUser != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Anunturi()),
                          (route) => false);
                    }
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


FutureBuilder<ModelFormular> buildFutureBuilder() {
    return FutureBuilder<ModelFormular>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nume!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

}
