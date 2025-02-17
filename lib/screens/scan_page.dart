import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'learn_more_page.dart';
import '../widget/drawer_menu.dart';
import '../widget/settings_page.dart';

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
    _controller = CameraController(cameras![0], ResolutionPreset.medium, enableAudio: false);
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

          // Top Right Menu Icon
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Image.asset(
                    'assets/widgets/menu-icon.png', // Ensure you have this image
                    width: 75,
                  ),
                  onPressed: () => _navigateToDrawer(context), // Call your function here
                ),
              ),
              
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


          // Scan My Waste Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.50,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Define your scan functionality here
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/widgets/black-btn.png',
                    height: 50,
                  ),
                  const Text(
                    "Scan My Waste",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Learn More Button
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LearnMorePage()),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/widgets/outlined-btn.png',
                    height: 60,
                  ),
                  const Text(
                    "Learn More",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Settings Button (Bottom Left)
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: Image.asset('assets/icon/settings-icon.png', height: 75), // Ensure image exists
              onPressed: () {
                _navigateToSettings(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _navigateToDrawer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrawerMenu()),
    );
  }

void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }