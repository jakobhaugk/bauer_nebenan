import 'package:flutter/material.dart';

import 'views/farmer_list.dart';

class FarmerScreen extends StatefulWidget {
    final Function navigateTo;

  const FarmerScreen({this.navigateTo});
  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return FarmerListView();
            }
          },
        ),
      );
}
