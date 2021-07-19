import 'package:flutter/material.dart';
import 'package:mackupapp/provider/GroceryBlocStore.dart';
import 'package:mackupapp/screens/welcomepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroceryStoreBloc>(
      create: (BuildContext context) {
        return GroceryStoreBloc();
      },
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
