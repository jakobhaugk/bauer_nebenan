import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  final num borderRadius, verticalPadding;
  final bool isDense;
  final String label;
  final Function(String) validator, onSaved;
  final EdgeInsets contentPadding, margin;
  final TextInputType keyboardType;

  RoundedTextField({
    this.borderRadius = 36,
    this.verticalPadding = 12,
    this.label = '',
    this.onSaved,
    this.validator,
    this.contentPadding,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.isDense = true,
    this.keyboardType,
  });

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField>
    with SingleTickerProviderStateMixin {
  FocusNode _focus = FocusNode();
  double _yPos, _scale;
  AnimationController _controller;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    )..addListener(() {
        setState(() {});
      });

    _focus.addListener(onFocusChange);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onFocusChange() {
    if (!_focus.hasFocus && _textEditingController.text.isEmpty)
      _controller.reverse();
    else
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _yPos = -2 * _controller.value;
    _scale = 1 - (_controller.value * 0.2);

    return Container(
      height: widget.validator != null ? 60 : null,
      margin: widget.margin,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          TextFormField(
            focusNode: _focus,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius.toDouble(),
                ),
              ),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: (widget.borderRadius / 2).toDouble(),
                    vertical: widget.verticalPadding.toDouble(),
                  ),
              isDense: widget.isDense,
            ),
            keyboardType: widget.keyboardType,
            controller: _textEditingController,
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
          IgnorePointer(
            child: Container(
              alignment: Alignment(0, -2),
              height: 45,
              child: Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.diagonal3Values(_controller.value * 0.9, 0.8, 1.0),
                child: Container(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 18,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              height: 45,
              alignment: Alignment(0, _yPos),
              child: Transform.scale(
                origin: Offset(0, -2),
                scale: _scale,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 18,
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

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Widget title,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
    EdgeInsets margin = const EdgeInsets.only(bottom: 8.0),
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return Builder(
                builder: (BuildContext context) => Container(
                  margin: margin,
                  height: validator != null ? 64 : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                          contentPadding: EdgeInsets.all(0),
                          activeColor: Theme.of(context).primaryColor,
                          dense: true,
                          title: title,
                          value: state.value,
                          onChanged: state.didChange,
                          controlAffinity: ListTileControlAffinity.leading),
                      if (state.hasError)
                        Builder(
                          builder: (BuildContext context) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              state.errorText,
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 13.2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
}

//   @override
//   CheckboxFormFieldState createState() => CheckboxFormFieldState();
//   // final Function validator, onSaved;
//   // final String label;
//   // final TextStyle labelStyle;
//   // final bool initValue;
// }

// class CheckboxFormFieldState extends State<CheckboxFormField> {
//   bool _checked;

//   @override
//   void initState() {
//     _checked = widget.initValue;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: _checked,
//           onChanged: (val) => setState(() => _checked = val),
//         ),
//         Text(
//           widget.label,
//           style: widget.labelStyle,
//         ),
//       ],
//     );
//   }
// }

class NameFields extends StatelessWidget {
  final Function onSave;

  NameFields({this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Vorname',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value.isEmpty ? 'Bitte gib deinen Vornamen ein' : true,
            onSaved: (value) => onSave(first: value),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Nachname', border: OutlineInputBorder()),
            validator: (value) =>
                value.isEmpty ? 'Bitte gib deinen Nachnamen ein' : true,
            onSaved: (value) => onSave(last: value),
          ),
        ),
      ],
    );
  }
}

class AddressFields extends StatelessWidget {
  final Function onSave;

  AddressFields({this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              labelText: 'Straße und Hausnummer', border: OutlineInputBorder()),
          validator: (value) => value.isEmpty
              ? 'Bitte gib deine Straße und Hausnummer ein'
              : true,
          onSaved: (value) => onSave(street: value),
        ),
        Row(children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'PLZ', border: OutlineInputBorder()),
              onSaved: (value) => onSave(zip: value),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Stadt', border: OutlineInputBorder()),
              onSaved: (value) => onSave(city: value),
            ),
          )
        ]),
      ],
    );
  }
}
