import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';
import '../widget/settings_page.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _isBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _isBottom = true;
          });
        } else {
          setState(() {
            _isBottom = false;
          });
        }
      } else {
        setState(() {
          _isBottom = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          SingleChildScrollView(
          controller: _scrollController,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Right Menu Icon
              Align(
                alignment: Alignment.topRight,
                child: Padding(
              padding: const EdgeInsets.all(16.0), 
                child: IconButton(
                  icon: Image.asset(
                    'assets/widgets/menu-icon.png',
                    width: 75,
                  ),
                  onPressed: () => _navigateToDrawer(context), 
                ),
              ),
            ),
            
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40), 
                  child: Text(
                    'How to Sort Your Recyclables',
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Simpsonfont',
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true, 
                  ),
                ),
        SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 10, 
                  crossAxisSpacing: 10, 
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
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40), 
                  child: Text(
                    '15 RECYCLING FUN FACTS!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Simpsonfont',
                    ),
                    softWrap: true, 
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
            SizedBox(height: 100),
          ],
        ),
      ),
      // Settings Button (Bottom Left)
          if (_isBottom)
            Positioned(
              bottom: 20,
              left: 20,
              child: IconButton(
                icon: Image.asset('assets/icon/settings-icon.png', height: 75), 
                onPressed: () {
                  _navigateToSettings(context);
                },
              ),
            ),
        ],
      ),
    );
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
        Image.asset(imageUrl, width: 150, height: 150),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              fontFamily: 'RinsHandwriting',
              height: 1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis, 
          ),
        ),
        Flexible(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              fontFamily: 'RinsHandwriting',
              height: 1,
            ),
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}