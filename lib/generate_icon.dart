import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1024x1024 boyutunda ikon oluştur
  const size = 1024.0;
  const backgroundColor = Color(0xFF4C6EF5);
  const iconColor = Colors.white;
  
  // Canvas oluştur
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  
  // Arka plan (yuvarlatılmış köşeler)
  final backgroundPaint = Paint()..color = backgroundColor;
  final borderRadius = size * 0.2; // 20% border radius
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size, size),
      Radius.circular(borderRadius),
    ),
    backgroundPaint,
  );
  
  // Canvas'ı 90 derece sağa (saat yönünde) döndür
  final center = Offset(size / 2, size / 2);
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(math.pi / 2); // 90 derece (π/2 radyan) saat yönünde
  canvas.translate(-center.dx, -center.dy);
  
  // Ana yıldız (merkez, büyük) - Splash screen'deki gibi
  final mainStarSize = size * 0.5;
  _drawStar(canvas, center, mainStarSize, iconColor);
  
  // İki küçük yıldız (splash screen'deki gibi)
  final smallStarSize = size * 0.15;
  final smallStarColor = iconColor;
  
  // Sol üst küçük yıldız
  _drawStar(canvas, Offset(size * 0.25, size * 0.3), smallStarSize, smallStarColor);
  // Sağ üst küçük yıldız
  _drawStar(canvas, Offset(size * 0.75, size * 0.3), smallStarSize, smallStarColor);
  
  canvas.restore();
  
  // PNG'ye kaydet
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();
  
  // Dosyaya yaz
  final file = File('assets/icons/app_icon.png');
  await file.parent.create(recursive: true);
  await file.writeAsBytes(pngBytes);
  
  print('✅ Icon created successfully at: ${file.absolute.path}');
  exit(0);
}

void _drawStar(Canvas canvas, Offset center, double size, Color color) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  
  final path = Path();
  final outerRadius = size * 0.5;
  final innerRadius = outerRadius * 0.4;
  
  // 5 köşeli yıldız çiz
  for (int i = 0; i < 5; i++) {
    final angle = (i * 2 * math.pi / 5) - (math.pi / 2);
    final x = center.dx + outerRadius * math.cos(angle);
    final y = center.dy + outerRadius * math.sin(angle);
    
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
    
    // İç nokta
    final innerAngle = angle + (math.pi / 5);
    final innerX = center.dx + innerRadius * math.cos(innerAngle);
    final innerY = center.dy + innerRadius * math.sin(innerAngle);
    path.lineTo(innerX, innerY);
  }
  path.close();
  
  canvas.drawPath(path, paint);
}

