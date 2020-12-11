import 'package:flutter/material.dart';

import 'home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bauer Nebenan',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Montserrat',
                fontSizeFactor: 1.1,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.light(
            primary: Colors.green[800],
          ),
          primaryColor: Colors.green[800],
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Montserrat',
        ),
        home: Home(),
      );
}
