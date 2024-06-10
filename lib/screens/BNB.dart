import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task00/screens/cart.dart';
import 'package:task00/screens/home.dart';

class Bnb extends StatefulWidget {
  const Bnb({super.key});

  @override
  State<Bnb> createState() => _BnbState();
}

class _BnbState extends State<Bnb> {
  int _selectedIndex = 0;
  int _cartItemCount = 0;
  final Stream<QuerySnapshot<Object?>> _cartStream = FirebaseFirestore.instance
      .collection('addedcart')
      .snapshots(); 

  @override
  void initState() {
    super.initState();
    _listenForCartChanges();
  }

void _listenForCartChanges() {
  _cartStream.listen((snapshot) {
    if (snapshot != null) {
      setState(() {
        _cartItemCount = snapshot.size;
      });
    } else {
      print("Error getting documents: Snapshot is null");
    }
  });
}


  @override
  void dispose() {
    super.dispose();
    _cartStream.listen((snapshot) {}).cancel();
  }

  void _incrementCartItemCount() {
    setState(() {
      _cartItemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 255, 99, 99),
        unselectedItemColor: Colors.black,
        items: _buildItems(),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
    );
  }

  List<Widget> screens = [
    Home(),
    Cart(),
  ];

  List<BottomNavigationBarItem> _buildItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Stack(
          children: [
            Icon(Icons.shopping_cart),
            _cartItemCount > 0
              ? Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_cartItemCount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox(), // Empty SizedBox when no count
          ],
        ),
        label: "Cart",
      ),
    ];
  }
}
