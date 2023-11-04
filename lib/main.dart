import 'package:elmatbakh/RecipePage.dart';
import 'package:elmatbakh/SettingsScreen.dart';
import 'package:elmatbakh/TabsControllerScreen.dart';
import 'package:elmatbakh/kitchenScreen.dart';
import 'package:flutter/material.dart';
import 'package:elmatbakh/categoryGrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (dummCtx) => TabsControllerScreen(),
        '/kitchenRoute': (dummyCtx) => KitchenScreen(),
        '/settingsRoute': (dummyCtx)=> SettingsScreen(),
        '/recipeRoute': (dummyCtx)=> RecipePage(),
      },
    );
  }
}
