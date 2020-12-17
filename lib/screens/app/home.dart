import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/shop/shop.dart';
import 'screens/cart/cart.dart';
import 'screens/farmer/farmer.dart';
import 'screens/profile/profile.dart';

class Screen {
  final String title, label, icon;
  final Widget appBar;
  final int index;

  Screen(this.index, this.title, this.icon, {this.appBar, this.label});
}

class Home extends StatefulWidget {
  final List<Screen> screens = <Screen>[
    Screen(0, 'Produkte', 'shop'),
    Screen(1, 'Warenkorb', 'cart'),
    Screen(2, 'Bauern', 'farmer'),
    Screen(3, 'Profil', 'home'),
  ];
  @override
  _HomeState createState() => _HomeState();
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

  void _navigate(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ShopScreen(navigateTo: _navigate),
      CartScreen(navigateTo: _navigate),
      FarmerScreen(navigateTo: _navigate),
      ProfileScreen(navigateTo: _navigate),
    ];
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
                  child: _screens[screen.index],
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
        onTap: _navigate,
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
