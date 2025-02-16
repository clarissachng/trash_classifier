import 'package:flutter/material.dart';

class FunFactPage extends StatefulWidget {
  const FunFactPage({super.key});

  @override
  _FunFactPageState createState() => _FunFactPageState();
}

class _FunFactPageState extends State<FunFactPage> {
  PageController _pageController = PageController();

  final List<String> _images = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg', 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('15 RECYCLING FUN FATCS!'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Fun Fact Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_left, size: 40),
                  onPressed: () {
                    if (_pageController.page! > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ),
              Positioned(
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_right, size: 40),
                  onPressed: () {
                    if (_pageController.page! < _images.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
