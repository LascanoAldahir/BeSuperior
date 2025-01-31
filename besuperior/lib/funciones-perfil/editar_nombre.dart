import 'package:flutter/material.dart';

class EditarNombreScreen extends StatefulWidget {
  final String nombreActual;
  final Function(String) onNombreCambiado;

  const EditarNombreScreen({
    Key? key,
    required this.nombreActual,
    required this.onNombreCambiado,
  }) : super(key: key);

  @override
  _EditarNombreScreenState createState() => _EditarNombreScreenState();
}

class _EditarNombreScreenState extends State<EditarNombreScreen> {
  late TextEditingController _nombreController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombreActual);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Nombre'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Guardar el nuevo nombre y regresar a la pantalla anterior
              widget.onNombreCambiado(_nombreController.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _nombreController,
          decoration: const InputDecoration(
            labelText: 'Nombre de usuario',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
