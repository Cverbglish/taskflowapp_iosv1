import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  final List<Map<String, String>> notifications = [
    {'title': 'Tarea pendiente', 'message': 'Recuerda completar tu tarea de Flutter.'},
    {'title': 'Nueva actualización', 'message': 'Hay una nueva versión disponible de la app.'},
    {'title': 'Recordatorio', 'message': 'No olvides revisar tus correos de trabajo.'},
    {'title': 'Cumpleaños', 'message': 'Hoy es el cumpleaños de tu amigo Juan.'},
    {'title': 'Reunión', 'message': 'Tienes una reunión programada a las 3 PM.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            title: notifications[index]['title']!,
            message: notifications[index]['message']!,
          );
        },
      ),
    );
  }
}


class NotificationCard extends StatelessWidget {
  final String title;
  final String message;

  const NotificationCard({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.notifications, color: Colors.purple),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          message,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purple),
        onTap: () {
          // Aquí puedes agregar la acción al hacer tap en la notificación
        },
      ),
    );
  }
}