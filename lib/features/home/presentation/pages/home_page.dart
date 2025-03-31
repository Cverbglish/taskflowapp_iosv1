import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de tareas (cada tarea puede tener una lista de tareas secundarias)
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Compras',
      'date': 'Hoy',
      'progress': '60%',
      'subtasks': ['Comprar leche', 'Comprar pan', 'Comprar frutas']
    },
    {
      'title': 'Estudiar Flutter',
      'date': 'Mañana',
      'progress': '30%',
      'subtasks': ['Leer documentación', 'Ver tutoriales', 'Practicar código']
    },
    {
      'title': 'Hacer ejercicio',
      'date': 'Hoy',
      'progress': '80%',
      'subtasks': ['Correr 30 min', 'Hacer abdominales', 'Estiramientos']
    },
    {
      'title': 'Reunión',
      'date': 'Mañana',
      'progress': '50%',
      'subtasks': ['Preparar presentación', 'Enviar agenda', 'Confirmar asistencia']
    },
    {
      'title': 'Proyectos',
      'date': 'Esta semana',
      'progress': '20%',
      'subtasks': ['Investigar sobre el tema', 'Iniciar desarrollo', 'Revisar avances']
    },
  ];

  // Variable para almacenar la tarea seleccionada
  int selectedTaskIndex = -1;

  @override
  void initState() {
    super.initState();
    // Seleccionar automáticamente la primera tarea con fecha "Hoy"
    selectedTaskIndex = tasks.indexWhere((task) => task['date'] == 'Hoy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text('Hola, Abraham', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/perfil.png'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ten un Excelente día!', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar Tareas...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Mis Tareas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // ListView horizontal para las tarjetas de tareas
            SizedBox(
              height: 200, // Ajusta la altura según el tamaño de tus tarjetas
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedTaskIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTaskIndex = isSelected ? -1 : index; // Cambia de seleccionado/no seleccionado
                        });
                      },
                      child: Container(
                        width: 250, // Ancho de la tarjeta
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.purple : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isSelected
                              // ignore: deprecated_member_use
                              ? [BoxShadow(color: Colors.purple.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index]['title']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              tasks[index]['date']!,
                              style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: double.parse(tasks[index]['progress']!.replaceAll('%', '')) / 100,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation(isSelected ? Colors.white : Colors.purple),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Progreso ${tasks[index]['progress']}',
                              style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Mostrar las tareas secundarias si hay una tarea seleccionada
            if (selectedTaskIndex != -1)
  Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tareas Secundarias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: tasks[selectedTaskIndex]['subtasks']!.length,
            itemBuilder: (context, subtaskIndex) {
              String subtask = tasks[selectedTaskIndex]['subtasks']![subtaskIndex];
              bool isCompleted = false; // Estado inicial de completado

              return Dismissible(
                key: Key(subtask),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Confirmar eliminación
                    bool? confirmDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Eliminar Tarea Secundaria'),
                          content: const Text('¿Estás seguro de que deseas eliminar esta tarea?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                    return confirmDelete ?? false;
                  } else if (direction == DismissDirection.endToStart) {
                    // Editar tarea secundaria
                    TextEditingController editController = TextEditingController(text: subtask);
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Editar Tarea Secundaria'),
                          content: TextField(
                            controller: editController,
                            decoration: const InputDecoration(labelText: 'Nueva descripción'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  tasks[selectedTaskIndex]['subtasks']![subtaskIndex] = editController.text;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );
                    return false; // No eliminar al editar
                  }
                  return false;
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    // Eliminar tarea secundaria
                    setState(() {
                      tasks[selectedTaskIndex]['subtasks']!.removeAt(subtaskIndex);
                    });
                  }
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(
                      subtask,
                      style: TextStyle(
                        fontSize: 16,
                        // ignore: dead_code
                        color: isCompleted ? Colors.grey : Colors.black,
                        // ignore: dead_code
                        decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          isCompleted = value!;
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}