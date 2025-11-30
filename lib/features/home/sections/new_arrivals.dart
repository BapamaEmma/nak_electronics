import 'package:flutter/material.dart';

class NewArrivalsSection extends StatefulWidget {
  const NewArrivalsSection({super.key});

  @override
  State<NewArrivalsSection> createState() => _NewArrivalsSectionState();
}

class _NewArrivalsSectionState extends State<NewArrivalsSection> {
  static const int _itemsPerPage = 5;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Product> _newProducts = [
    Product(
      id: '1',
      name: 'Gibson SG Standard Coffee Colour Limited Edition',
      price: 2500.00,
      originalPrice: 3000.00,
      imagePath: 'assets/images/gibsonsg.png',
      isNew: true,
      discount: 17,
    ),
    Product(
      id: '2',
      name: 'MG 16-Channel Mixer Available In Stock',
      price: 1500.00,
      originalPrice: 1800.00,
      imagePath: 'assets/images/MG mixer.png',
      isNew: true,
      discount: 17,
    ),
    Product(
      id: '3',
      name: 'JBL SRX828SP Double 18" Subwoofer Speaker',
      price: 15000.00,
      originalPrice: 12000.00,
      imagePath: 'assets/images/jblsub.png',
      isNew: true,
      discount: 16,
    ),
    Product(
      id: '4',
      name: 'Fender Player Stratocaster',
      price: 2800.00,
      originalPrice: 3200.00,
      imagePath: 'assets/images/fender player.png',
      isNew: true,
      discount: 13,
    ),
    Product(
      id: '5',
      name: 'Studio Headphones Pro Monitoring',
      price: 750.00,
      originalPrice: 900.00,
      imagePath: 'assets/images/headset.png',
      isNew: true,
      discount: 17,
    ),
    Product(
      id: '6',
      name: 'Condenser Microphone with XLR',
      price: 980.00,
      originalPrice: 1200.00,
      imagePath: 'assets/images/microphone.png',
      isNew: true,
      discount: 18,
    ),
    Product(
      id: '7',
      name: 'Compact Audio Interface 2x2',
      price: 1100.00,
      originalPrice: 1300.00,
      imagePath: 'assets/images/recording.png',
      isNew: true,
      discount: 15,
    ),
    Product(
      id: '8',
      name: 'Studio Monitor Speaker Pair',
      price: 2200.00,
      originalPrice: 2600.00,
      imagePath: 'assets/images/monitor.png',
      isNew: true,
      discount: 15,
    ),
    Product(
      id: '9',
      name: 'Professional Stage Mixer 12-Channel',
      price: 3500.00,
      originalPrice: 3999.00,
      imagePath: 'assets/images/mixer.png',
      isNew: true,
      discount: 12,
    ),
    Product(
      id: '10',
      name: 'High-Power Guitar Amplifier 100W',
      price: 1950.00,
      originalPrice: 2200.00,
      imagePath: 'assets/images/amp.png',
      isNew: true,
      discount: 11,
    ),
    Product(
      id: '11',
      name: 'Electric Bass Guitar 5-String',
      price: 2750.00,
      originalPrice: 3100.00,
      imagePath: 'assets/images/guitar.png',
      isNew: true,
      discount: 11,
    ),
    Product(
      id: '12',
      name: 'Pearl Drum Kit 5-Piece',
      price: 9000.00,
      originalPrice: 11000.00,
      imagePath: 'assets/images/drums.png',
      isNew: true,
      discount: 8,
    ),
    Product(
      id: '13',
      name: '61-Key Portable Keyboard',
      price: 1600.00,
      originalPrice: 1850.00,
      imagePath: 'assets/images/keyboard.png',
      isNew: true,
      discount: 14,
    ),

    Product(
      id: '14',
      name: 'LED Stage Lighting Pack',
      price: 1300.00,
      originalPrice: 1500.00,
      imagePath: 'assets/images/lighting.png',
      isNew: true,
      discount: 13,
    ),
    Product(
      id: '14',
      name: 'DLX-D4(2 in 1)Microphone',
      price: 2300.00,
      originalPrice: 2500.00,
      imagePath: 'assets/images/DLX-D4.png',
      isNew: true,
      discount: 15,
    ),
  ];

  void _nextPage() {
    if (_currentPage < (_newProducts.length / _itemsPerPage).ceil() - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'New Arrivals',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            height: 450,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: (_newProducts.length / _itemsPerPage).ceil(),
                  itemBuilder: (context, pageIndex) {
                    final startIndex = pageIndex * _itemsPerPage;
                    final endIndex = (startIndex + _itemsPerPage).clamp(
                      0,
                      _newProducts.length,
                    );
                    final pageProducts = _newProducts.sublist(
                      startIndex,
                      endIndex,
                    );

                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: pageProducts.map((product) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: SizedBox(
                              width: 220,
                              child: ProductCard(product: product),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                // Navigation arrows
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black54,
                          size: 24,
                        ),
                        onPressed: _previousPage,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black54,
                          size: 24,
                        ),
                        onPressed: _nextPage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Shop Now button
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to products page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.red, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                elevation: 0,
              ),
              child: const Text(
                'Shop Now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final String imagePath;
  final bool isNew;
  final int? discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.imagePath,
    this.isNew = false,
    this.discount,
  });
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 12 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image with NEW badge
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          widget.product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.music_note,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    ),
                    if (widget.product.isNew)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Product details
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'GH ${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
