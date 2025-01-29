import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo negro para toda la pantalla
      backgroundColor: const Color(0xFF000000),
      // SafeArea para evitar superposiciones con áreas del sistema
      body: SafeArea(
        child: Padding(
          // Padding horizontal de 20 píxeles
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40), // Espacio vacío de 40 píxeles
              Expanded(
                // GridView para mostrar las tarjetas de ejercicios
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 15, // Espacio horizontal entre elementos
                    mainAxisSpacing: 15, // Espacio vertical entre elementos
                    childAspectRatio: 0.55, // Relación ancho/alto de las tarjetas
                  ),
                  itemCount: 4, // Número de tarjetas
                  itemBuilder: (context, index) {
                    // Lista de ejercicios con títulos e imágenes
                    final exercises = [
                      {'title': 'Cuerpo Completo', 'image': 'lib/assets/cuerpo_completo.png'},
                      {'title': 'Pecho', 'image': 'lib/assets/pecho.png'},
                      {'title': 'Abdominales', 'image': 'lib/assets/abdominales.png'},
                      {'title': 'Piernas', 'image': 'lib/assets/piernas.png'},
                    ];
                    // Construye cada tarjeta de ejercicio
                    return _buildExerciseCard(
                      exercises[index]['title']!, // Título del ejercicio
                      exercises[index]['image']!, // Ruta de la imagen
                      context, // Contexto para la navegación
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir cada tarjeta de ejercicio
  Widget _buildExerciseCard(String title, String imagePath, BuildContext context) {
    return GestureDetector(
      // Detecta toques en la tarjeta
      onTap: () {
        // Navega a la pantalla de detalles del ejercicio
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailScreen(
              title: title,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        // Decoración de la tarjeta
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
          boxShadow: [
            // Sombra alrededor de la tarjeta
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          // Recorta los bordes redondeados
          borderRadius: BorderRadius.circular(25.0),
          child: Stack(
            // Superpone widgets
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath, // Imagen de fondo
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el espacio
              ),
              Container(
                // Gradiente semitransparente sobre la imagen
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de detalles del ejercicio
class ExerciseDetailScreen extends StatelessWidget {
  final String title;
  final String imagePath;

  const ExerciseDetailScreen({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE7DC), // Fondo color crema
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF00796B), // Verde azulado
      ),
      body: Column(
        children: [
          // Header con imagen
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Duración y número de ejercicios
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard("32 min", "Duración"),
                _infoCard("28", "Ejercicios"),
              ],
            ),
          ),

          // Lista de ejercicios
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Número de ejercicios (cambia según la rutina)
              itemBuilder: (context, index) {
                return _exerciseTile("Burpies", "00:30"); // Ejemplo de ejercicio
              },
            ),
          ),

          // Botón para iniciar la rutina
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para iniciar la rutina
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6200EA), // Morado
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Iniciar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para las tarjetas de información (Duración, Ejercicios)
  Widget _infoCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Widget para cada fila de ejercicio
  Widget _exerciseTile(String title, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.play_arrow, // Ícono temporal
              size: 30,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}