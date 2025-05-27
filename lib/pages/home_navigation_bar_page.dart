import 'package:flutter/material.dart';
import 'package:practica_3/pages/home_page.dart';
import 'package:practica_3/pages/search_page.dart';
import 'package:practica_3/pages/messages_page.dart';
import 'package:practica_3/pages/agenda_page.dart';
import 'package:practica_3/pages/profile_page.dart';

class HomeNavigationBarPage extends StatefulWidget {
  const HomeNavigationBarPage({super.key});

  @override
  State<HomeNavigationBarPage> createState() => _HomeNavigationBarPageState();
}

class _HomeNavigationBarPageState extends State<HomeNavigationBarPage> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomePage(),
    SearchPage(),
    MessagesPage(),
    AgendaPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SportLink")),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Busqueda"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Mensajes"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Agenda"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "Mi perfil"
          )
        ],
        backgroundColor: const Color(0xFF0F8555).withValues(alpha: 0.7),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
