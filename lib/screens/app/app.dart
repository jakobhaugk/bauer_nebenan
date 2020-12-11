import 'package:flutter/material.dart';

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
        home: Scaffold(
          appBar: AppBar(
            title: Text('Bauer nebenan'),
          ),
          body: Center(
            child: Text('Home'),
          ),
        ),
      );
}
