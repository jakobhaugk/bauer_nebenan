import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/shop/shop.dart';
import 'screens/cart/cart.dart';
import 'screens/farmer/farmer.dart';
import 'screens/profile/profile.dart';

class Screen {
  final String title, label;
  final IconData icon;
  final Widget body, appBar;
  final int index;

  Screen(this.index, this.title, this.icon, this.body,
      {this.appBar, this.label});
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  final List<Screen> screens = <Screen>[
    Screen(0, 'Produkte', Icons.favorite, ShopScreen()),
    Screen(1, 'Warenkorb', Icons.shopping_basket, CartScreen()),
    Screen(2, 'Bauern', Icons.eco, FarmerScreen()),
    Screen(3, 'Profil', Icons.home, ProfileScreen()),
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
              )
            );
            if (screen.index == _index) {
              _faders[screen.index].forward();
              return view;
            } else {
              _faders[screen.index].reverse();
              if (_faders[screen.index].isAnimating) return IgnorePointer(child: view);
              return Offstage(child: view);
            }
          }).toList(),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _index,
          onTap: (int i) {
            setState(() => _index = i);
          },
          items: widget.screens
              .map((Screen screen) => BottomNavigationBarItem(
                    icon: Icon(screen.icon),
                    label: screen.title,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: false,
//         child: IndexedStack(
//           index: _index,
//           children: widget.screens
//               .map<Widget>((Screen screen) => screen.body)
//               .toList(),
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 60,
//         child: BottomNavigationBar(
//           showUnselectedLabels: true,
//           selectedItemColor: Theme.of(context).primaryColor,
//           unselectedItemColor: Colors.grey,
//           currentIndex: _index,
//           onTap: (int i) {
//             setState(() => _index = i);
//           },
//           items: widget.screens
//               .map((Screen screen) => BottomNavigationBarItem(
//                     icon: Icon(screen.icon),
//                     label: screen.title,
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
