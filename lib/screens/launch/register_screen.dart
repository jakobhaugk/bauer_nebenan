import 'package:bauer_nebenan/widgets/hero_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../provider/user_provider.dart';
import '../../widgets/buttons.dart';
import '../../widgets/form_fields.dart';

RegExp emailRegex = RegExp(r'^\S+@\S+\.\S+$');

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  User _user;
  bool _keyboardVisible = false;

  _submit() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      
      form.save();

      User newUser = User();

      try {
        newUser = await Provider.of<UserProvider>(context, listen: false).register(_user);
      } catch (e) {}

      if (newUser.status == UserStatus.firstLogin) Navigator.of(context).pushReplacementNamed('/first-login');
      else if (newUser.readyToShop) Navigator.of(context).pushReplacementNamed('/app');
      else Navigator.of(context).pushReplacementNamed('/waiting');
      
      return true;

    } else return 'pass';
  }

  @override
  void initState() {
    _user = User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!_keyboardVisible)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HeroLogo(startingIn: 'Gießen'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Registriere dich jetzt und fang an, regional zu bestellen!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      RoundedTextField(
                        label: 'Straße und Hausnummer',
                        onSaved: (val) =>
                            setState(() => _user.address.street = val),
                        validator: (val) =>
                            val.isEmpty ? 'Bitte gib deine Adresse ein' : null,
                      ),
                      RoundedTextField(
                        label: 'Postleitzahl',
                        keyboardType: TextInputType.number,
                        onSaved: (val) =>
                            setState(() => _user.address.zip = val),
                        validator: (val) => val.isEmpty || val.length != 5
                            ? 'Bitte gib deine Postleitzahl ein'
                            : null,
                      ),
                      RoundedTextField(
                          label: 'E-Mail Adresse',
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val.isEmpty || !emailRegex.hasMatch(val)
                                  ? 'Bitte gib deine E-Mail Adresse ein'
                                  : null,
                          onSaved: (val) => setState(
                                () => _user.username = val,
                              )),
                      CheckboxFormField(
                        title: const Text(
                            'Ich habe die Datenschutzerklärung gelesen und akzeptiere diese.'),
                        initialValue: _user.acceptsPrivacyPolicy,
                        onSaved: (val) =>
                            setState(() => _user.acceptsPrivacyPolicy = val),
                        validator: (val) => !val
                            ? 'Bitte akzeptiere die Datenschutzerklärung'
                            : null,
                      ),
                      SubmitButton(
                        onPressed: _submit,
                        init: 'Platz sichern',
                        loading: 'Adresse wird gesucht',
                        success: 'Du bist dabei!',
                        showMsg: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
