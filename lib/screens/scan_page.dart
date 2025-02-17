import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'learn_more_page.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan My Waste"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Centered Camera Preview
          // Positioned Camera Preview
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1, // Adjust to move up/down
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _controller == null || !_controller!.value.isInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CameraPreview(_controller!),
                ),
              ),
            ),
          ),


          // Capture Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.50,
            left: 20, // Centers the button
            right: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text("Scan My Waste", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),

          // Learn More Button
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LearnMorePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text(
                "Learn More",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
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
