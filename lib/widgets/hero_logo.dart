import 'package:flutter/material.dart';

class HeroLogo extends StatelessWidget {
  final String startingIn;
  final bool showWelcome;
  final EdgeInsets margin;

  const HeroLogo({
    this.startingIn,
    this.showWelcome = false,
    this.margin =
        const EdgeInsets.only(top: 48, left: 36, right: 36, bottom: 24),
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: Column(
          children: [
            if (showWelcome)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('Willkommen bei'.toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 3,
                      wordSpacing: 6,
                      fontSize: 18,
                    )),
              ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/logo/logo.png',
                    )),
                Expanded(
                  flex: 4,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Bauer Nebenan',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (startingIn != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text('Wir starten bald in'.toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 3,
                      wordSpacing: 3,
                      fontSize: 18,
                    )),
              ),
            if (startingIn != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Icon(Icons.location_pin,
                          size: 28, color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      startingIn,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              )
          ],
        ),
      );
}
