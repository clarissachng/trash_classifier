import 'package:flutter/material.dart';

void main() {
  runApp(Funfact());
}

class Funfact extends StatelessWidget {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20, 
                runSpacing: 10, 
                children: [
                  RecyclingItem(imageUrl: 'assets/bins/green_wheelie_bin.png', title: 'Green wheelie bin', description: 'Garden waste'),
                  RecyclingItem(imageUrl: 'assets/bins/black_wheelie_bin.png', title: 'Black wheelie bin', description: 'Non-recyclable waste'),
                  RecyclingItem(imageUrl: 'assets/bins/food_waste.png', title: 'Brown bin', description: 'Food waste'),
                  RecyclingItem(imageUrl: 'assets/bins/green_box.png', title: 'Green box', description: 'Plastic and metal'),
                  RecyclingItem(imageUrl: 'assets/bins/blue_bag.png', title: 'Blue bag', description: 'Cardboard and brown paper'),
                  RecyclingItem(imageUrl: 'assets/bins/black_box.png', title: 'Black box', description: 'Glass, paper, and others'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '15 RECYCLING FUN FACTS!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset('assets/arrow/arrow.png', width: 158, height: 79), 
            ),
            SizedBox(height: 10),
            RecyclingFactsCarousel(),
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}


class RecyclingFactsCarousel extends StatelessWidget {
  final List<String> imagePaths = List.generate(
    15,
    (index) => 'assets/funfacts/funfact_${index + 1}.png',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 568, 
      child: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePaths[index],
              width: 568,
              height: 568,
              fit: BoxFit.cover, 
            ),
          );
        },
      ),
    );
  }
}