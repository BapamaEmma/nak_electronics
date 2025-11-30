// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';

class PopularCategoriesSection extends StatefulWidget {
  const PopularCategoriesSection({super.key});

  @override
  State<PopularCategoriesSection> createState() =>
      _PopularCategoriesSectionState();
}

class _PopularCategoriesSectionState extends State<PopularCategoriesSection> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final List<_Category> _categories = const [
    _Category('PA System & Live Sound', 'assets/images/sound.png'),
    _Category('Drums & Percussion', 'assets/images/drums.png'),
    _Category('Keyboard', 'assets/images/keyboard.png'),
    _Category('Headphones', 'assets/images/headset.png'),
    _Category('Microphones', 'assets/images/microphone.png'),
    _Category('Amplifiers', 'assets/images/amp.png'),
    _Category('Guitars & Bass', 'assets/images/guitar.png'),
    _Category('Studio Monitors', 'assets/images/monitor.png'),
    _Category('Mixers', 'assets/images/mixer.png'),
    _Category('Recording Gear', 'assets/images/recording.png'),
    _Category('Lighting & Effect', 'assets/images/lighting.png'),
  ];

  final int _currentPage = 0;
  static const int _itemsPerPage = 10; // Changed from 4 to 10 (5x2 grid)

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Popular Categories',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          height: 300, // Reduced height to move cards to top
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 220, 227, 224),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    child: _CategoryCard(category: _categories[index]),
                  );
                },
              ),
              // Left arrow
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        228,
                        153,
                        153,
                      ).withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: _scrollLeft,
                    ),
                  ),
                ),
              ),
              // Right arrow
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        228,
                        153,
                        153,
                      ).withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 20),
                      onPressed: _scrollRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _Category {
  final String name;
  final String imagePath;
  const _Category(this.name, this.imagePath);
}

class _CategoryCard extends StatelessWidget {
  final _Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18), // Increased border radius
          child: Image.asset(
            category.imagePath,
            width: 200, // Increased from 120
            height: 160, // Increased from 80
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 200,
              height: 180,
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                size: 48, // Increased from 30
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16), // Increased from 8
        Text(
          category.name,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18, // Increased from 14
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
