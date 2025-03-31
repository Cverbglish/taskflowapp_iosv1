import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/perfil.png'),
            ),
            SizedBox(height: 10),
            Text('Abraham Mozqueda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Realizando Tareas...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}