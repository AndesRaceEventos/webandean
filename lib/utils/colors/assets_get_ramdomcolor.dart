import 'dart:math';
import 'dart:ui';

Color getRandomColor() {
  final Random random = Random();

  return Color.fromARGB(
    255,
    random.nextInt(256), // Rojo en el rango 100-155
    random.nextInt(256), // Verde en el rango 100-199
    random.nextInt(256), // Azul en el rango 100-155
  );
}

Color getRandomColorMutedColor() {
  
  final Random random = Random();
  
  // Generar componentes de color en un rango más alto
  int r = random.nextInt(56) + 200; // Rango de 200 a 255
  int g = random.nextInt(56) + 200; // Rango de 200 a 255
  int b = random.nextInt(56) + 200; // Rango de 200 a 255

  // Crear un color opaco sin transparencia
  return Color.fromRGBO(r, g, b, 1.0); // Opacidad 1.0 (sin transparencia)
}





List<Color> getGradientColors(int count) {
  final Random random = Random();
  
  // Generar un color base en un rango específico
  int r = random.nextInt(150) + 50; // Rango de 50 a 200
  int g = random.nextInt(150) + 50; // Rango de 50 a 200
  int b = random.nextInt(150) + 50; // Rango de 50 a 200
  
  Color baseColor = Color.fromRGBO(r, g, b, 1.0);

  // Generar una lista de colores en gradiente
  List<Color> gradientColors = [];
  for (int i = 0; i < count; i++) {
    // Calcula el factor de aclarado
    double factor = 1 - (i * 0.1); // Cada color será un 10% más claro que el anterior
    gradientColors.add(
      Color.fromRGBO(
        (baseColor.red + (255 - baseColor.red) * (1 - factor)).toInt(),
        (baseColor.green + (255 - baseColor.green) * (1 - factor)).toInt(),
        (baseColor.blue + (255 - baseColor.blue) * (1 - factor)).toInt(),
        .4, // Opacidad total
      ),
    );
  }
  
  return gradientColors;
}
