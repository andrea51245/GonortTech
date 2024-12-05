import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerScreen extends StatefulWidget {
  const ModelViewerScreen({Key? key}) : super(key: key);

  @override
  _EstudioDeModelos3DState createState() => _EstudioDeModelos3DState();
}

class _EstudioDeModelos3DState extends State<ModelViewerScreen> {
  // Lista de modelos 3D con sus rutas
  final List<String> modelPaths = [
    'assets/3D/audifonos.glb',
    'assets/3D/Telefono_barcelona.glb',
    'assets/3D/Telefono_deadpool.glb',
    'assets/3D/conector.glb',
    'assets/3D/cargador.glb',
    'assets/3D/bocina.glb',
    'assets/3D/audifonos2.glb',
    'assets/3D/Telefono_rosa.glb',
    'assets/3D/Telefono_rudo.glb',
    'assets/3D/Telefono_skull.glb',
  ];

  // Lista de imágenes para los círculos
  final List<String> circleImagePaths = [
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
    'assets/Botones/aqua.png',
  ];

  Color circleBackgroundColor =
      const Color.fromARGB(255, 0, 0, 0); // Color de fondo de los círculos

  int selectedModelIndex = 0; // Índice del modelo seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Icono negro
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/logo_negro.png', // Ruta del logo
          height: 40, // Ajustar el tamaño de la imagen
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.white, // Fondo blanco
        centerTitle: true, // Centrar la imagen
        elevation: 0, // Eliminar sombra del AppBar
      ),
      body: Column(
        children: [
          // Área principal del visor 3D
          Expanded(
            child: ModelViewer(
              key: ValueKey<int>(selectedModelIndex), // Forzar redibujado
              src: modelPaths[
                  selectedModelIndex], // Cargar el modelo seleccionado
              alt: 'Modelo no disponible',
              autoRotate: true, // Activar rotación automática
              cameraControls: true, // Permitir interacción con la cámara
              backgroundColor:
                  const Color.fromARGB(255, 0, 0, 0), // Fondo negro
            ),
          ),
          // Fila de círculos con imágenes
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: circleBackgroundColor, // Color de fondo de los círculos
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(circleImagePaths.length, (index) {
                return GestureDetector(
                  onTap: () {
                    // Cambiar el modelo cuando se hace clic en un círculo
                    setState(() {
                      selectedModelIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage(circleImagePaths[index]), // Asignar imagen
                      radius: 25,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
