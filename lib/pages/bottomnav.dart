import 'package:appshopbread/pages/profile.dart';
import 'package:appshopbread/pages/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'order.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _pages = [
    Home(),
    Order(),
    Wallet(),
    Profile(),
  ];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
      backgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 500),
      color: Colors.black87,
      onTap: (value) {
        setState(() {
          selected = value;
        });
      },
        index: selected,
      items: [
        Icon(Icons.home,size: 30,color: Colors.white,),
        Icon(Icons.shopping_bag,size: 30,color: Colors.white,),
        Icon(Icons.wallet,size: 30,color: Colors.white,),
        Icon(Icons.person,size: 30,color: Colors.white,),
      ],
      ),
      body: _pages[selected]
    );
  }
}
