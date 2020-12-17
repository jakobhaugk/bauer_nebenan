import 'package:flutter/material.dart';

import 'views/profile_dashboard.dart';

class ProfileScreen extends StatefulWidget {
  
  final Function navigateTo;

  const ProfileScreen({this.navigateTo});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return ProfileDashboardView();
            }
          },
        ),
      );
}
