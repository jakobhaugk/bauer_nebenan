import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final Widget icon;
  final Widget text;

  ButtonWithIcon({this.icon, this.text});

  @override
  Widget build(BuildContext context) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (this.icon != null)
              Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(right: 12),
                  child: this.icon),
            if (this.text != null)
              Container(
                height: 36,
                alignment: Alignment.centerLeft,
                child: this.text,
              )
          ]);
}

class SubmitButton extends StatefulWidget {
  final String init, loading, success, failure;
  final dynamic onPressed;
  final bool showMsg, rounded;

  SubmitButton({
    this.init = 'Aktualisieren',
    this.loading = 'Wird aktualisiert',
    this.success = 'Erfolgreich aktualisiert',
    this.failure = 'Fehlgeschlagen',
    this.onPressed,
    this.showMsg = false,
    this.rounded = true,
  });

  _SubmitButtonState createState() => _SubmitButtonState(button: this);
}

class _SubmitButtonState extends State<SubmitButton> {
  SubmitButton button;
  _SubmitButtonState({this.button, this.style});

  Widget _buttonContent;
  ButtonStyle style;

  @override
  void initState() {
    _buttonContent = ButtonWithIcon(text: Text(widget.init));
    super.initState();
  }

  void _handleSubmit() {
    setState(() {
      _buttonContent = FutureBuilder(
        future: button.onPressed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ButtonWithIcon(
                icon: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
                text: Text(button.loading));
          else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == false) {
              return ButtonWithIcon(
                  icon: Icon(Icons.error, color: Colors.white),
                  text: Text(button.showMsg
                      ? snapshot.error.toString()
                      : button.failure));
            } else if (snapshot.data == 'pass') {
              return ButtonWithIcon(text: Text(widget.init));
            } else
              return ButtonWithIcon(
                  icon: Icon(Icons.done, color: Colors.white),
                  text: Text(button.success));
          }
          return Text('Lädt');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) => RoundedButton(
        onPressed: _handleSubmit,
        child: _buttonContent,
      );
}

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Size minSize;
  final TextStyle textStyle;
  final EdgeInsets margin;

  RoundedButton({
    this.child,
    this.onPressed,
    this.minSize = const Size(240.0, 45.0),
    this.textStyle,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: minSize,
            textStyle: textStyle,
          ),
        ),
      );
}
