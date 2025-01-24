import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Establece un fondo negro para toda la pantalla
      backgroundColor: const Color(0xFF000000), // Color negro
      // SafeArea asegura que el contenido no se superponga con áreas del sistema
      body: SafeArea(
        child: Padding(
          // Padding horizontal de 20 píxeles en ambos lados
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40), //Espacio vacio de 20 piceles de alto
              Expanded(
                //expande el widget GridView para ocupar todo el espacio disponible
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Dos columnas en el GridView
                    crossAxisSpacing: 15, // Separacion horizontal entre elementos
                    mainAxisSpacing: 15, //Separación vertical entre elementos
                    childAspectRatio: 0.55, // Relacion ancho y alto de los elementos
                  ),
                  itemCount: 4, //Numero total de elementos en el GridView
                  itemBuilder: (context, index) {
                    //Lista de ejercicios con títulos e imágenes
                    final exercises = [
                      {'title': 'Cuerpo Completo', 'image': 'lib/assets/cuerpo_completo.png'},
                      {'title': 'Pecho', 'image': 'lib/assets/pecho.png'},
                      {'title': 'Abdominales', 'image': 'lib/assets/abdominales.png'},
                      {'title': 'Piernas', 'image': 'lib/assets/piernas.png'},
                    ];
                    //Crea cada tarjeta de ejercicio utilizando _buildExerciseCard
                    return _buildExerciseCard(
                      exercises[index]['title']!, //Titulo del Ejercicio
                      exercises[index]['image']!, //Ruta de la imagen
                      context, //Contexto para la navegacion
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
  //Metodo para construir cada tarjeta de ejercicio.
  Widget _buildExerciseCard(String title, String imagePath, BuildContext context) {
    return GestureDetector(
      // Detecta toques en la tarjeta
      onTap: () {
        //Navega a una nueva pantalla al tocar la tarjeta
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(title)), // Título del AppBar
              body: Center(child: Text('$title Screen')), // Contenido de la nueva pantalla
            ),
          ),
        );
      },
      child: Container(
        //Contenedor principal con decoracion
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), //Bordes redondeados de 25 pixeles
          boxShadow: [
            //Sombra alrededor de la tarjeta
            BoxShadow(
              color: Colors.black.withOpacity(0.2), //Sombra Negra
              blurRadius: 8, //Desenfoque de la sombra
              spreadRadius: 2, //Expansion de la sombra
            ),
          ],
        ),
        child: ClipRRect(
          //Permite recortar los bordes redondeadas del contenido
          borderRadius: BorderRadius.circular(25.0),
          child: Stack(
            //Permite superponer widgets
            fit: StackFit.expand, //Hace que los widgets hijos ocupen todo el espacio
            children: [
              Image.asset(
                imagePath, // Imagen de fondo de la targeta
                fit: BoxFit.cover, //Ajustar la imagen para cubrir todo el espacio disponible
              ),
              Container(
                //Capa de gradiente semitransparente sobre la imagen
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, //Inicio del gradiente
                    end: Alignment.bottomCenter, //Fin del gradiente
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