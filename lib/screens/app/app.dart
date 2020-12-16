import 'package:bauer_nebenan/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NavProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
          title: 'Bauer Nebenan',
          home: Home(),
          theme: Theme.of(context)
        ),
  );
}
