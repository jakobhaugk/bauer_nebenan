import 'package:flutter/material.dart';

class RowCard extends StatelessWidget {
  final double height, padding;
  final Widget leading, content;
  final Function onTap;

  const RowCard(
      {Key key,
      this.height,
      this.leading,
      this.content,
      this.onTap,
      this.padding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(height / 2),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: Offset(0, 2)),
            ],
          ),
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height / 2),
                  child: Container(
                    width: height,
                    height: height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: leading,
                    ),
                  ),
                ),
              ),
              content
            ],
          ),
        ),
      ),
    );
  }
}
