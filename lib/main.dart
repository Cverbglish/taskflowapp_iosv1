import 'package:flutter/material.dart';
import 'package:taskflow_app/features/home/presentation/pages/home_page.dart';
import 'package:taskflow_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:taskflow_app/features/profile/presentation/pages/profile_page.dart';
import 'package:taskflow_app/features/task/presentation/pages/task_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      home: MainPage()
    );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Índice de la pestaña actual (Tareas)

  final List<Widget> _pages = [
    const HomePage(), // Página de inicio (reemplaza con tu pantalla real)
    const TaskPage(), // Página de Tareas
    const NotificationsPage(), // Página de Notificaciones (reemplaza con tu pantalla real)
    const ProfilePage(), // Página de Perfil (reemplaza con tu pantalla real)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Muestra la página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tareas'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}