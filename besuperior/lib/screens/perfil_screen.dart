import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:besuperior/funciones-perfil/editar_nombre.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String _nombreUsuario = "Usuario"; // Estado para el nombre de usuario
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _documentId = ""; // ID del documento en Firestore

  @override
  void initState() {
    super.initState();
    _cargarNombreUsuario(); // Cargar el nombre al iniciar la pantalla
  }

  // Método para cargar el nombre de usuario desde Firestore
  Future<void> _cargarNombreUsuario() async {
    try {
      // Verifica si ya existe un documento en la colección "usuarios"
      QuerySnapshot snapshot =
          await _firestore.collection('usuarios').limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        // Si existe un documento, carga sus datos
        setState(() {
          _nombreUsuario =
              snapshot.docs.first['nombre'] ?? 'Usuario sin nombre';
          _documentId = snapshot.docs.first.id; // Guarda el ID del documento
        });
      } else {
        // Si no existe un documento, crea uno nuevo con un nombre por defecto
        DocumentReference nuevoDocumento =
            _firestore.collection('usuarios').doc();
        await nuevoDocumento.set({
          'nombre': _nombreUsuario,
          'creadoEn': FieldValue.serverTimestamp(),
        });

        setState(() {
          _documentId = nuevoDocumento.id; // Guarda el ID del nuevo documento
        });
      }
    } catch (e) {
      print("Error al cargar el nombre de usuario: $e");
    }
  }

  // Método para actualizar el nombre de usuario en Firestore y en la UI
  Future<void> _actualizarNombre(String nuevoNombre) async {
    try {
      await _firestore.collection('usuarios').doc(_documentId).update({
        'nombre': nuevoNombre,
      });

      setState(() {
        _nombreUsuario = nuevoNombre;
      });
    } catch (e) {
      print("Error al actualizar el nombre: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 100, 0, 150),
              Color.fromARGB(220, 0, 0, 90),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _nombreUsuario,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // Navegar a la pantalla de edición de nombre
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarNombreScreen(
                            nombreActual: _nombreUsuario,
                            onNombreCambiado: _actualizarNombre,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // CircleAvatar con tamaño máximo
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 200, // Tamaño máximo del avatar
                  maxHeight: 200,
                ),
                child: const CircleAvatar(
                  radius: 90, // Tamaño fijo o responsivo
                  backgroundImage: AssetImage('./lib/images/image.png'),
                ),
              ),
              const SizedBox(height: 20),
              // Tarjetas superiores con tamaño máximo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _buildCard("Días ejercitados", screenWidth * 0.4,
                          screenHeight * 0.12),
                    ),
                    const SizedBox(width: 10), // Espacio entre las tarjetas
                    Flexible(
                      child: _buildCard(
                          "Fotos", screenWidth * 0.4, screenHeight * 0.12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Lista de tarjetas con tamaño máximo
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCard(
                        "Modo Oscuro", double.infinity, screenHeight * 0.1),
                    const SizedBox(height: 20),
                    _buildCard("Envía tus comentarios", double.infinity,
                        screenHeight * 0.1),
                    const SizedBox(height: 20),
                    _buildCard("Acerca de la aplicación", double.infinity,
                        screenHeight * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 142, 139, 139),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
