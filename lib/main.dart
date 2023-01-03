import 'package:auto_sales_flutter/cars/formular_cars.dart';
import 'package:auto_sales_flutter/models/anunt_piese.dart';
import 'package:auto_sales_flutter/screens/login.dart';
import 'package:auto_sales_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:auto_sales_flutter/splash_screen.dart';
import 'package:auto_sales_flutter/cars/anunturi_masini.dart';
import 'package:auto_sales_flutter/home.dart';


void main() {
  runApp( AutoSales());
}

class AutoSales extends StatelessWidget {
  const AutoSales({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auto_Sales',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Auto Sales'),
          ),
          body: Register(),
        ));
  }
}
