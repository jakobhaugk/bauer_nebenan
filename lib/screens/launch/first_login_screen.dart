import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../../provider/text_provider.dart';
import '../../widgets/hero_logo.dart';
import '../../widgets/buttons.dart';

class FirstLoginScreen extends StatefulWidget {
  @override
  _FirstLoginScreenState createState() => _FirstLoginScreenState();
}

class _FirstLoginScreenState extends State<FirstLoginScreen> {
  List<String> textLines;
  ConfettiController _confettiController;

  @override
  void initState() {
    String welcomeText = Provider.of<TextProvider>(context, listen: false).text['welcomeText'];
    textLines = welcomeText.split('\n') ?? [welcomeText];
    print(textLines);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiController.play();
    
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: HeroLogo(showWelcome: true),
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
              SizedBox(height: 108)
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.all(36.0),
                child: RoundedButton(
                  child: Text('Zum Shop'),
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/app'),
                ),
              ),
          )
        ],
      ),
    );
  }
}
