import "package:flutter/material.dart";
import './screens/perfil_screen.dart'; // Importación de PerfilScreen

void main() {
  runApp(const MyApp());
}

// Widget principal de la app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta Debug
      title: 'BeSuperior',
      home: const HomePage(), // Página inicial
    );
  }
}

// Widget que representa la página principal con navegación
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado asociado a HomePage
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Índice que controla qué pantalla se muestra

  // Lista de pantallas
  final List<Widget> _pages = [
    const CalendarioScreen(), // Pantalla de Calendario
    const ExerciseScreen(), // Pantalla de Rutinas
    const PerfilScreen(), // Pantalla de Perfil
  ];

  // Método que se llama cuando se presiona un ítem del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Eliminamos el AppBar
      body: IndexedStack(
        index: _selectedIndex, // Muestra solo la pantalla seleccionada
        children: _pages, // Lista de pantallas
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex, // Índice del elemento seleccionado
        selectedItemColor: Colors.purple, // Color del elemento seleccionado
        unselectedItemColor:
            Colors.grey, // Color de los elementos no seleccionados
        onTap: _onItemTapped, // Llama a la función al presionar un ícono
      ),
    );
  }
}

// Pantalla de Calendario
class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Calendario'), // Contenido vacío
    );
  }
}

// Pantalla de Rutinas
class RutinasScreen extends StatelessWidget {
  const RutinasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Rutinas'), // Contenido vacío
    );
  }
}
