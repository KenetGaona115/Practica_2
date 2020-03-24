import 'package:flutter/material.dart';
import 'package:practica_dos/acerca/about.dart';
import 'package:practica_dos/apuntes/apuntes.dart';
import 'package:practica_dos/recordatorios/reminder.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  final _pages = [
    ReminderPage(),
    Apuntes(),
    About(),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget._pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Todos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text("Apuntes"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Acerca"),
          ),
        ],
      ),
    );
  }
}
