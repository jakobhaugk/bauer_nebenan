import 'package:bauer_nebenan/screens/app/screens/shop/views/product_detail.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final bool pinned;
  final Widget header, body;
  final double headerExpandedHeight, headerCollapsedHeight, initScrollOffset;

  const Details({Key key, this.pinned = false, @required this.header, @required this.body, this.headerExpandedHeight, this.headerCollapsedHeight = 150.0, this.initScrollOffset}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  ScrollController _scrollController;

  @override
    void initState() {
      _scrollController = ScrollController(initialScrollOffset: widget.initScrollOffset);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(0, 50),
          ),
          pinned: widget.pinned,
          expandedHeight: widget.headerExpandedHeight,
          collapsedHeight: widget.headerCollapsedHeight,
          flexibleSpace: Stack(
            children: [
              Positioned(
                  child: widget.header,
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0),
              Positioned(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(48),
                    ),
                  ),
                ),
                bottom: -1,
                left: 0,
                right: 0,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Scrollbar(
            child: Container(child: widget.body),
          )
        )
      ]
    );
  }
}