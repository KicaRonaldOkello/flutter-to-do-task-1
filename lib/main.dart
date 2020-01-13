import 'package:flutter/material.dart';

import 'package:flutter_to_do/router.dart';

void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
    );
  }

}