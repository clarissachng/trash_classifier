import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan My Waste"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: _controller == null || !_controller!.value.isInitialized
                ? const Center(child: CircularProgressIndicator())
                : CameraPreview(_controller!),
          ),

          // Capture Button
          Positioned(
            bottom: 80, // Adjust this value if needed
            left: 20, // Centers the button
            right: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text("Capture", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),

          // Settings Button (Bottom Left)
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: Image.asset('assets/icon/settings-icon.png', height: 40), // Ensure image exists
              onPressed: () {
                // Open settings or navigate to settings page
              },
            ),
          ),
        ],
      ),
    );
  }
}
