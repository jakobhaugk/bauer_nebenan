import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../provider/text_provider.dart';
import '../../widgets/hero_logo.dart';
import '../../widgets/buttons.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  List<String> textLines;

  @override
  initState() {
    String waitingListText = Provider.of<TextProvider>(context, listen: false).text['waitingListText'];
    textLines = waitingListText.split('\n') ?? [waitingListText];
    super.initState();
  }


  Future _newsletter() async => Provider.of<UserProvider>(context, listen: false).newsletterSignUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: HeroLogo(),
          ),
          Container(
                margin: EdgeInsets.all(36.0),
                child: Column(
                  children: textLines
                      .map(
                        (String text) => Padding(
                          padding: const EdgeInsets.only(bottom: 48.0),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          Container(
            margin: EdgeInsets.all(36.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Wenn du dich für das Projekt interessierst, tregen wir dich gern in unseren Newsletter ein:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SubmitButton(
                  onPressed: _newsletter,
                  init: 'Haltet mich auf dem Laufenden',
                  loading: 'Wir tragen dich ein',
                  success: 'Erfolgreich eingetragen',
                  showMsg: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
