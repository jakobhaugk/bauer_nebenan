import 'loading_icons.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class LoadingScreen extends StatelessWidget {
  final String title;
  final String loading;
  final bool logo;
  final bool empty;
  LoadingScreen(
      {this.title = "", this.loading, this.logo = false, this.empty = false});

  @override
  Widget build(BuildContext context) {
    if (this.empty)
      return Scaffold();
    else if (this.loading != null)
      return Scaffold(
          body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: this.loading,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Center(
                  child: LoadingIcons(
                firstIconIndex: 1,
                iconSize: 70.0,
                numberOfIcons: 7,
                radius: 0.7,
                derivation: 0.3,
                popInterval: 300,
                delayOffset: 2000,
              )),
            )
          ],
        ),
      ));
    else if (this.logo)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: FadeIn(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Image.asset(
                'assets/logo/logo.png',
                width: 250,
              ),
            ),
          ),
          if (this.title != null)
            Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ))
        ],
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: CircularProgressIndicator()),
          if (this.title != null)
            Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ))
        ],
      );
  }
}
