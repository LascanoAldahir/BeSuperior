import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//Widget principal de la app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta Debug
      title: 'BeSuperior',
      home: HomePage(), // Página inicial
    );
  }
}

//Widget que respresenta la pagina principal con navegacion
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
//Estado asociado a HomePage
class _HomePageState extends State<HomePage> {
  late int _selectedIndex = 0; //Indice que controla que pantalla se muestra

  // Lista de pantallas
  final List<Widget> _pages = const [
    const CalendarioScreen(), // Pantalla de Calendario
    const RutinasScreen(), // Pantalla de Rutinas
    const PerfilScreen(), // Pantalla de Perfil
  ];

  //Metodo que se llama cuando se presiona un ítem del BottomNavigationBar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0; // Inicializa el índice seleccionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()), // Título dinámico basado en la pantalla actual
        backgroundColor: Colors.purple, //Color de fondo del AppNar
      ),
      body: IndexedStack(
        index: _selectedIndex, // Muestra solo la pantalla seleccionada
        children: _pages, // Lista de pantallas
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        unselectedItemColor: Colors.grey, // Color de los elementos no seleccionados
        onTap: _onItemTapped, // Llama a la función al presionar un ícono
      ),
    );
  }

  // Obtiene el título basado en la pantalla actual
  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Calendario';
      case 1:
        return 'Rutinas';
      case 2:
        return 'Perfil';
      default:
        return 'BeSuperior';
    }
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

// Pantalla de Perfil
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Perfil'), // Contenido vacío
    );
  }
}
