import 'package:bauer_nebenan/widgets/buttons.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../widgets/hero_logo.dart';

class FirstLaunchScreen extends StatelessWidget {
  final List<Map> steps = [
    {
      'img': 'assets/icons/intro/0.png',
      'text': 'Prüfe ob deine Stadt dabei ist'
    },
    {'img': 'assets/icons/intro/1.png', 'text': 'Fülle deinen Einkaufskorb'},
    {'img': 'assets/icons/intro/2.png', 'text': 'Wöchentlich oder einmalig'},
    {
      'img': 'assets/icons/intro/3.png',
      'text': 'Frisch an deine Tür geliefert'
    },
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            DelayedDisplay(
              delay: Duration(milliseconds: 250),
              slidingBeginOffset: Offset(0, -0.2),
              child: Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: HeroLogo(showWelcome: true),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: steps
                      .asMap()
                      .entries
                      .map(
                        (entry) => DelayedDisplay(
                          delay: Duration(milliseconds: 1500 + entry.key * 500),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Image.asset(entry.value['img'])),
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Text(
                                      entry.value['text'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 4000),
              child: Padding(
                padding: EdgeInsets.all(36.0),
                child: RoundedButton(
                  child: Text('Los gehts'),
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/register'),
                ),
              ),
            ),
          ],
        ),
      );
}
