import 'package:bauer_nebenan/screens/launch/first_launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../provider/user_provider.dart';
import '../../provider/text_provider.dart';

import '../app/app.dart';
import '../loading/loading_screen.dart';
import '../error/error_screen.dart';
import 'register_screen.dart';
import 'waiting_screen.dart';
import 'first_login_screen.dart';


class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  Future<User> userFuture;

  Future<User> _init() async {
    await Provider.of<TextProvider>(context, listen: false).load();
    return Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  void initState() {
    super.initState();
    userFuture = _init();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return LoadingScreen(logo: true);

            case ConnectionState.active:
              return LoadingScreen(logo: true);

            case ConnectionState.waiting:
              return LoadingScreen(logo: true);

            case ConnectionState.done:
              if (snapshot.hasError) return ErrorScreen(message: snapshot.error,);
              else if (snapshot.hasData) {
                User _user = snapshot.data;
                return App();

                switch (_user.status) {
                  case UserStatus.firstLaunch:
                    return FirstLaunchScreen();

                  case UserStatus.unregistered:
                    return RegisterScreen();

                  case UserStatus.waiting:
                    return WaitingScreen();

                  case UserStatus.firstLogin:
                    return FirstLoginScreen();

                  case UserStatus.unlocked:
                  case UserStatus.complete:
                    return App();

                  default:
                    return RegisterScreen();
                }
              }
              else return ErrorScreen();
          }

          return LoadingScreen(logo: true);
        },
      );
}
