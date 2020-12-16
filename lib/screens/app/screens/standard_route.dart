import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../error/error_screen.dart';

class StandardRoute extends PageTransition {
  final Widget body;
  final String title;
  final PageTransitionType transition;
  final String name;

  StandardRoute({
    this.body,
    this.title,
    this.transition,
    this.name,
  }) : super(
          child: Body(body: body, title: title),
          duration: Duration(milliseconds: 250),
          reverseDuration: Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          type: transition,
          settings: RouteSettings(name: name),
        );
}

class Body extends StatefulWidget {
  final String title;
  final Widget body;

  const Body({Key key, this.title, this.body}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didPopRoute() async {
    print(ModalRoute.of(context).settings.name);
    if (ModalRoute.of(context).settings.name == '/') return false;
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title != null)
          ? AppBar(
              title: Text(widget.title),
              centerTitle: true,
            )
          : null,
      body: widget.body ?? ErrorScreen(),
    );
  }
}
