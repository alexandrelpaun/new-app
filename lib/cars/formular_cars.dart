import 'package:auto_sales_flutter/cars/anunturi_masini.dart';
import 'package:auto_sales_flutter/models/model_formular.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_sales_flutter/models/anunt_cars.dart';

Future<http.Response> sendEmail(ModelFormular mesaj) async {
  String SENDGRID_API_KEY =
      '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';

  final response = await http.post(
      Uri.parse('https://api.sendgrid.com/v3/mail/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $SENDGRID_API_KEY' // nu am reusit sa obtin token key, inca incecrc sa inregistrez DNS in wordPress
      },
      body:'{"personalizations": [{"to": [{"email": "${mesaj.email}"}]}],"from": {"email": "alex@em381.samsareala.ro"},"subject": "Sending with SendGrid is Fun","content": [{"type": "text/plain", "value": "and easy to do anywhere, even with cURL"}]}'
          );

  print(response.body);

  return (response);
}

class Formular extends StatefulWidget {
  const Formular({super.key});

  @override
  State<Formular> createState() => _FormularState();
}

class _FormularState extends State<Formular> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Future<ModelFormular>? _futureModelFormular;

  @override
  void dispose() {
    emailController.dispose();
    numeController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerere Oferta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            TextFormField(
              controller: numeController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'nume',
                labelText: 'nume',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: 'telefon',
                labelText: 'telefon',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 50.0),
            TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'email',
                  labelText: 'email',
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80.0))),
                ),
                keyboardType: TextInputType.emailAddress,
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
                onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    print(
                        '${emailController.text} - ${numeController.text} - ${phoneController.text}');

                    ModelFormular mesaj = new ModelFormular(
                        email: emailController.text,
                        telefon: phoneController.text,
                        nume: numeController.text);

                   await sendEmail(mesaj);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Anunturi()),
                        (route) => false);
                  }
                },
                child: Text(
                  'Trimitere',
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
      future: _futureModelFormular,
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
