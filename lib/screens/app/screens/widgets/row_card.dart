import 'package:flutter/material.dart';

class RowCard extends StatelessWidget {
  final double height, topPadding, sidePadding;
  final Widget leading, content, trailing;
  final Color color;
  final Function onTap;

  const RowCard({
    this.height,
    this.leading,
    this.content,
    this.trailing,
    this.onTap,
    this.topPadding = 0.0,
    this.sidePadding = 24.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: topPadding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
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
              if (leading != null) Padding(
                padding: EdgeInsets.only(right: sidePadding),
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
              Expanded(child: content ?? Container()),
              if (trailing != null) Padding(
                padding: EdgeInsets.only(left: sidePadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height / 2),
                  child: Container(
                    width: height,
                    height: height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: trailing,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
