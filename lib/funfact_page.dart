import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecyclingPage(),
    );
  }
}

class RecyclingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Sort Your Recyclables'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            RecyclingItem(
              imageUrl: 'assets/bins/green_wheelie_bin.png',
              title: 'Green wheelie bin:',
              description: 'Garden waste',
            ),
            RecyclingItem(
              imageUrl: 'assets/bins/black_wheelie_bin.png',
              title: 'Black wheelie bin:',
              description: 'Non-recyclable waste',
            ),
            RecyclingItem(
              imageUrl: 'assets/bins/food_waste.png',
              title: 'Brown bin:',
              description: 'Food waste',
            ),
            RecyclingItem(
              imageUrl: 'assets/bins/green_box.png',
              title: 'Green box:',
              description: 'Plastic and metal',
            ),
            RecyclingItem(
              imageUrl: 'assets/bins/blue_bag.png',
              title: 'Blue bag:',
              description: 'Cardboard and brown paper',
            ),
            RecyclingItem(
              imageUrl: 'assets/bins/black_box.png',
              title: 'Black box:',
              description: 'Glass, paper, and others',
            ),
            SizedBox(height: 20),
            Text(
              '15 RECYCLING FUN FACTS!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: RecyclingFactsCarousel(),
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl, width: 80, height: 80), 
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(description),
            ],
          ),
        ],
      ),
    );
  }
}

class RecyclingFactsCarousel extends StatefulWidget {
  @override
  _RecyclingFactsCarouselState createState() => _RecyclingFactsCarouselState();
}

class _RecyclingFactsCarouselState extends State<RecyclingFactsCarousel> {
  final PageController _controller = PageController();

  final List<String> facts = [
    'It takes as few as 30 days for a glass container to go from a recycling bin back to a store shelf.',
    'Recycling one aluminum can saves enough energy to run a TV for three hours.',
    'Every ton of recycled paper saves 17 trees and 7,000 gallons of water.',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: facts.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  facts[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
