import 'package:flutter/material.dart';
import 'package:custom_interactive_viewer/custom_interactive_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotation Fixes Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RotationTestPage(),
    );
  }
}

class RotationTestPage extends StatefulWidget {
  const RotationTestPage({super.key});

  @override
  State<RotationTestPage> createState() => _RotationTestPageState();
}

class _RotationTestPageState extends State<RotationTestPage> {
  late CustomInteractiveViewerController _controller;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = CustomInteractiveViewerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateContent(double angle) {
    setState(() {
      _rotation += angle;
    });
    _controller.rotateTo(
      _rotation,
      focalPoint: const Offset(200, 200),
      animate: true,
    );
  }

  void _centerOnRect() {
    // Test centering on a specific rectangle when content is rotated
    _controller.centerOnRect(
      const Rect.fromLTWH(100, 100, 200, 200),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Rotation Fixes')),
      body: Column(
        children: [
          // Control buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: () => _rotateContent(0.785398), // 45 degrees
                  child: const Text('Rotate +45°'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateContent(-0.785398), // -45 degrees
                  child: const Text('Rotate -45°'),
                ),
                ElevatedButton(
                  onPressed: _centerOnRect,
                  child: const Text('Center on Red Square'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.reset(animate: true),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.fitToScreen(animate: true),
                  child: const Text('Fit to Screen'),
                ),
              ],
            ),
          ),
          Text(
            'Current rotation: ${(_rotation * 180 / 3.14159).toStringAsFixed(1)}°',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Use arrow keys to test constrained keyboard navigation',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          // Interactive viewer
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: CustomInteractiveViewer(
                controller: _controller,
                contentSize: const Size(400, 400),
                interactionConfig: const InteractionConfig(
                  constrainBounds: true,
                  enableRotation: true,
                ),
                keyboardConfig: const KeyboardConfig(
                  enableKeyboardControls: true,
                  keyboardPanDistance: 20,
                ),
                child: Container(
                  width: 400,
                  height: 400,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      // Grid background
                      CustomPaint(
                        size: const Size(400, 400),
                        painter: GridPainter(),
                      ),
                      // Red square at (100, 100) with size 200x200
                      Positioned(
                        left: 100,
                        top: 100,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.3),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: const Center(
                            child: Text(
                              'Target Rectangle',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Center marker
                      const Positioned(
                        left: 195,
                        top: 195,
                        child: Icon(
                          Icons.center_focus_strong,
                          color: Colors.blue,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey[400]!
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
