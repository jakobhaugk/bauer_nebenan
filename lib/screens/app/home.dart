import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/shop/shop.dart';
import 'screens/cart/cart.dart';
import 'screens/farmer/farmer.dart';
import 'screens/profile/profile.dart';

class Screen {
  final String title, label, icon;
  final Widget body, appBar;
  final int index;

  Screen(this.index, this.title, this.icon, this.body,
      {this.appBar, this.label});
}

final Map<String, GlobalKey<NavigatorState>> navKeys = {
  'shop': GlobalKey<NavigatorState>(debugLabel: 'navKey shop'),
  'cart': GlobalKey<NavigatorState>(debugLabel: 'navKey cart'),
  'farmer': GlobalKey<NavigatorState>(debugLabel: 'navKey farmer'),
  'home': GlobalKey<NavigatorState>(debugLabel: 'navKey home'),
};

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  final List<Screen> screens = <Screen>[
    Screen(0, 'Produkte', 'shop', ShopScreen(navKeys: navKeys)),
    Screen(1, 'Warenkorb', 'cart', CartScreen()),
    Screen(2, 'Bauern', 'farmer', FarmerScreen()),
    Screen(3, 'Profil', 'home', ProfileScreen()),
  ];
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  List<Key> _screenKeys;
  List<AnimationController> _faders;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _faders = widget.screens
        .map((_) => AnimationController(
            vsync: this, duration: Duration(milliseconds: 250)))
        .toList();

    _screenKeys =
        List<Key>.generate(widget.screens.length, (_) => GlobalKey()).toList();
  }

  @override
  void dispose() {
    _faders.forEach((AnimationController c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: widget.screens.map((Screen screen) {
            final Widget view = FadeTransition(
                opacity: _faders[screen.index].drive(
                  CurveTween(curve: Curves.fastOutSlowIn),
                ),
                child: KeyedSubtree(
                  key: _screenKeys[screen.index],
                  child: screen.body,
                ));
            if (screen.index == _index) {
              _faders[screen.index].forward();
              return view;
            } else {
              _faders[screen.index].reverse();
              if (_faders[screen.index].isAnimating)
                return IgnorePointer(child: view);
              return Offstage(child: view);
            }
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (int i) {
          setState(() => _index = i);
        },
        items: widget.screens
            .map((Screen screen) => BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/nav/${screen.icon}.png',
                    height: 30,
                  ),
                  label: screen.title,
                ))
            .toList(),
      ),
    );
  }
}
