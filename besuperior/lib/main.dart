import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); //Constructor con un parametro

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeSuperior',
      debugShowCheckedModeBanner: false, //oculta la etiqueta Debug en la esquina
      home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();//Crea el estado para la pagina
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //Controlla que elemento del Navbar esta seleccionado

  //Lista de títulos para las diferentes pantallas
  static const List<String> _pageTitles = [
    'Calendario',
    'Rutinas',
    'Perfil',
  ];

  //Aqui se podrian agregar widgets de las pantallas correspondientes.
  static const List<Widget> _pages = [
    Center(child: Text('Pantalla de Calendario')),
    Center(child: Text('Pantalla de Rutinas')),
    Center(child: Text('Pantalla de Perfil')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //Cambia el indice seleccionado al presionar un boton del navbar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]), //Cambia el titulo segun el indice seleccionado
        backgroundColor: Colors.purple, //Color de fondo del AppBar
      ),
      body: _pages[_selectedIndex], //Muestra la pantalla correspondiente al indice seleccionado
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
        currentIndex: _selectedIndex, //Indica cual es elemento seleccionado actualmente
        selectedItemColor: Colors.purple,//Color del elemento seleccionado.
        unselectedItemColor: Colors.grey, //Color de elementos no seleccionados
        onTap: _onItemTapped, //Llama a la funcion cuando un elemento es presionado
      ),
    );
  }
}

