import 'package:flutter/material.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/core/utils/image_widget.dart';

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
      image: 'assets/images/gibsonsg.png',
      category: 'Guitars & Bass',
      brand: 'Gibson',
      description: 'Limited edition Gibson SG guitar',
      isNew: true,
      discount: 0.17,
    ),
    Product(
      id: '2',
      name: 'MG 16-Channel Mixer Available In Stock',
      price: 1500.00,
      image: 'assets/images/MG mixer.png',
      category: 'Mixers',
      brand: 'Yamaha',
      description: '16-channel mixer',
      isNew: true,
      discount: 0.17,
    ),
    Product(
      id: '3',
      name: 'JBL SRX828SP Double 18" Subwoofer Speaker',
      price: 15000.00,
      image: 'assets/images/jblsub.png',
      category: 'PA System & Live Sound',
      brand: 'JBL',
      description: 'Double 18" subwoofer',
      isNew: true,
      discount: 0.16,
    ),
    Product(
      id: '4',
      name: 'Fender Player Stratocaster',
      price: 2800.00,
      image: 'assets/images/fender player.png',
      category: 'Guitars & Bass',
      brand: 'Fender',
      description: 'Player Stratocaster guitar',
      isNew: true,
      discount: 0.13,
    ),
    Product(
      id: '5',
      name: 'Studio Headphones Pro Monitoring',
      price: 750.00,
      image: 'assets/images/headset.png',
      category: 'Headphones',
      brand: 'Generic',
      description: 'Pro monitoring headphones',
      isNew: true,
      discount: 0.17,
    ),
    Product(
      id: '6',
      name: 'Condenser Microphone with XLR',
      price: 980.00,
      image: 'assets/images/microphone.png',
      category: 'Microphones',
      brand: 'Generic',
      description: 'Condenser mic with XLR',
      isNew: true,
      discount: 0.18,
    ),
    Product(
      id: '7',
      name: 'Compact Audio Interface 2x2',
      price: 1100.00,
      image: 'assets/images/recording.png',
      category: 'Recording Gear',
      brand: 'Generic',
      description: '2x2 audio interface',
      isNew: true,
      discount: 0.15,
    ),
    Product(
      id: '8',
      name: 'Studio Monitor Speaker Pair',
      price: 2200.00,
      image: 'assets/images/monitor.png',
      category: 'Studio Monitors',
      brand: 'Generic',
      description: 'Pair of studio monitors',
      isNew: true,
      discount: 0.15,
    ),
    Product(
      id: '9',
      name: 'Professional Stage Mixer 12-Channel',
      price: 3500.00,
      image: 'assets/images/mixer.png',
      category: 'Mixers',
      brand: 'Generic',
      description: '12-channel stage mixer',
      isNew: true,
      discount: 0.12,
    ),
    Product(
      id: '10',
      name: 'High-Power Guitar Amplifier 100W',
      price: 1950.00,
      image: 'assets/images/amp.png',
      category: 'Amplifiers',
      brand: 'Generic',
      description: '100W guitar amp',
      isNew: true,
      discount: 0.11,
    ),
    Product(
      id: '11',
      name: 'Electric Bass Guitar 5-String',
      price: 2750.00,
      image: 'assets/images/guitar.png',
      category: 'Guitars & Bass',
      brand: 'Generic',
      description: '5-string bass guitar',
      isNew: true,
      discount: 0.11,
    ),
    Product(
      id: '12',
      name: 'Pearl Drum Kit 5-Piece',
      price: 9000.00,
      image: 'assets/images/drums.png',
      category: 'Drums & Percussion',
      brand: 'Pearl',
      description: '5-piece drum kit',
      isNew: true,
      discount: 0.08,
    ),
    Product(
      id: '13',
      name: '61-Key Portable Keyboard',
      price: 1600.00,
      image: 'assets/images/keyboard.png',
      category: 'Keyboard',
      brand: 'Generic',
      description: '61-key portable keyboard',
      isNew: true,
      discount: 0.14,
    ),
    Product(
      id: '14',
      name: 'LED Stage Lighting Pack',
      price: 1300.00,
      image: 'assets/images/lighting.png',
      category: 'Lighting & Effect',
      brand: 'Generic',
      description: 'LED stage lighting pack',
      isNew: true,
      discount: 0.13,
    ),
    Product(
      id: '15',
      name: 'DLX-D4(2 in 1)Microphone',
      price: 2300.00,
      image: 'assets/images/DLX-D4.png',
      category: 'Microphones',
      brand: 'Generic',
      description: '2-in-1 microphone',
      isNew: true,
      discount: 0.15,
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
                              child: ProductCard(
                                product: product,
                              ),
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

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
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
                          child: ProductImage(
                            imagePath: widget.product.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
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
                          '₵${widget.product.discountedPrice.toStringAsFixed(0)}',
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
      ),
    );
  }
}