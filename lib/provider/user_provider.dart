import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../util/fetch.dart';

class UserProvider extends ChangeNotifier {
  User user;

  // init user from device storage with username and password
  Future<void> _init() async {
    if (user != null) return;

    FlutterSecureStorage _storage = FlutterSecureStorage();
    user = User.fromStorage(await _storage.readAll());
  }

  // check if user logs in first time and sets status
  Future<void> _checkFirstLogin() async {
    if (user.readyToShop) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstLogin = prefs.getBool('firstLogin') ?? true;
      if (firstLogin) {
        user.status = UserStatus.firstLogin;
        prefs.setBool('firstLogin', false);
      }
    }
  }

  Future<User> getUser() async {
    await _init();

    if (user == null || user.isEmpty) {
      UserStatus status;
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstLaunch = prefs.getBool('firstLaunch') ?? true;

      if (firstLaunch) {
        status = UserStatus.firstLaunch;
        prefs.setBool('firstLaunch', false);
      } else status = UserStatus.unregistered;

      return User(status: status);
    }

    Map res = await fetch('post', 'login', body: user.loginBody);
    user = User.fromJSON(res, former: user);

    _checkFirstLogin();

    return user;
  }

  Future<User> register(User userData) async {
    Map res = await fetch('post', 'register', body: userData.toJSON());

    user = User.fromJSON(res, former: userData);

    _checkFirstLogin();

    return user;
  }

  Future<Map> newsletterSignUp() async {
    if (user == null) throw ('user is not defined');
    return await fetch('post', 'newsletter', body: {'signup': user.username});
  }

  
}
