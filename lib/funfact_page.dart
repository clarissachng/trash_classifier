import 'package:flutter/material.dart';

void main() {
  runApp(Funfact());
}

class Funfact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      fontFamily: 'RinsHandwriting',
    ),
      home: RecyclingPage(),
    );
  }
}

class RecyclingPage extends StatefulWidget {
  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How to Sort Your Recyclables',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'RinsHandwriting',
            fontWeight: FontWeight.bold, 
            ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 10, 
                  crossAxisSpacing: 20, 
                  childAspectRatio: 1, 
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final items = [
                    RecyclingItem(imageUrl: 'assets/bins/green_wheelie_bin.png', title: 'Green wheelie bin:', description: 'Garden waste'),
                    RecyclingItem(imageUrl: 'assets/bins/black_wheelie_bin.png', title: 'Black wheelie bin:', description: 'Non-recyclable waste'),
                    RecyclingItem(imageUrl: 'assets/bins/food_waste.png', title: 'Brown bin:', description: 'Food waste'),
                    RecyclingItem(imageUrl: 'assets/bins/green_box.png', title: 'Green box:', description: 'Plastic and metal'),
                    RecyclingItem(imageUrl: 'assets/bins/blue_bag.png', title: 'Blue bag:', description: 'Cardboard and brown paper'),
                    RecyclingItem(imageUrl: 'assets/bins/black_box.png', title: 'Black box:', description: 'Glass, paper, and others'),
                  ];
                  return items[index];
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              '15 RECYCLING FUN FACTS!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold, 
                fontFamily: 'RinsHandwriting',
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/arrow/arrow.png', width: 683, height: 79),
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (_pageController.page! > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      width: 79, 
                      height: 79,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (_pageController.page! < 14) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      width: 79, 
                      height: 79,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 300, 
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/funfacts/funfact_${index + 1}.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class RecyclingItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  RecyclingItem({required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 100, height: 100),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.normal, 
            fontSize: 14,
            fontFamily: 'RinsHandwriting',
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal, 
            fontFamily: 'RinsHandwriting',
          ),
        ),
      ],
    );
  }
}