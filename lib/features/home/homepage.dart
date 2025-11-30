// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nak_electronics/features/home/sections/categories.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/features/home/sections/brands.dart';
import 'package:nak_electronics/features/home/sections/new_arrivals.dart';
import 'package:nak_electronics/features/home/sections/featured_products.dart';
import 'package:nak_electronics/features/home/sections/special_deals.dart';
import 'package:nak_electronics/features/home/sections/testimonials.dart';
import 'package:nak_electronics/features/home/sections/newsletter.dart';
import 'package:nak_electronics/features/home/sections/footer.dart';

class NaknaaHomePage extends StatefulWidget {
  const NaknaaHomePage({super.key});

  @override
  State<NaknaaHomePage> createState() => _NaknaaHomePageState();
}

class _NaknaaHomePageState extends State<NaknaaHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Added: scroll controller + keys for sections
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _categoriesKey = GlobalKey();
  final GlobalKey _newArrivalsKey = GlobalKey();
  final GlobalKey _featuredKey = GlobalKey();
  final GlobalKey _dealsKey = GlobalKey();
  final GlobalKey _brandsKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _newsletterKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  final List<_HeroSlide> _slides = [
    _HeroSlide(
      image: "assets/images/hero1.png",
      title: "GET HIGH YOUR QUALITY\nMUSICAL INSTRUMENT",
      subtitle:
          "Shop premium instruments from trusted brands\n"
          "Unbeatable deals at your fingertips\n"
          "Fast delivery, easy checkout, secure payment\n"
          "Naknaa Where customers shop with confidence.",
      titleStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Poppins',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      subtitleStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
    _HeroSlide(
      image: "assets/images/hero2.png",
      title: "DISCOVER NEW SOUNDS",
      subtitle:
          "Explore a wide range of instruments\n"
          "Top brands for every level of musician\n"
          "From classics to the latest trends\n"
          "Your perfect sound starts here.",
      titleStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Poppins',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      subtitleStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
    _HeroSlide(
      image: "assets/images/hero3.png",
      title: "START YOUR MUSIC JOURNEY",
      subtitle:
          "Find the perfect instrument to begin or grow\nyour musical adventure.",
      titleStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Poppins',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      subtitleStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  // Added helper to scroll to a keyed widget
  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = 1400;
    final double heroHeight = MediaQuery.of(context).size.height * 0.80;

    return Scaffold(
      body: Column(
        children: [
          // Pass a callback to the appbar so nav menu items can request scrolling
          SizedBox(
            width: 1600,
            height: 70,
            child: _CustomAppBar(
              onItemSelected: (title) {
                switch (title) {
                  case 'Home':
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    break;
                  case 'Categories':
                    _scrollToKey(_categoriesKey);
                    break;
                  case 'Deals & Offers':
                    _scrollToKey(_dealsKey);
                    break;
                  case 'Brands':
                    _scrollToKey(_brandsKey);
                    break;
                  case 'About Us':
                    _scrollToKey(_footerKey);
                    break;
                  default:
                    break;
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          // The rest of the content is scrollable
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: SizedBox(
                            height: heroHeight,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                PageView.builder(
                                  controller: _pageController,
                                  itemCount: _slides.length,
                                  onPageChanged: (index) {
                                    setState(() => _currentPage = index);
                                    _controller.forward(from: 0);
                                  },
                                  itemBuilder: (context, index) {
                                    final slide = _slides[index];
                                    return Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          slide.image,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    color: Colors.grey[400],
                                                  ),
                                        ),
                                        Container(
                                          color: Colors.black.withOpacity(0.45),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 80,
                                            right: 32,
                                            bottom: 80,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: 600,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    slide.title,
                                                    style: slide.titleStyle,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    slide.subtitle,
                                                    style: slide.subtitleStyle,
                                                  ),
                                                  const SizedBox(height: 32),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                            0xFFFF8B8B,
                                                          ),
                                                      foregroundColor:
                                                          Colors.black87,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              24,
                                                            ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 32,
                                                            vertical: 16,
                                                          ),
                                                      textStyle:
                                                          const TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      'Get Started',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                // Left arrow
                                Positioned(
                                  left: 24,
                                  bottom: 24,
                                  child: FloatingActionButton(
                                    heroTag: "left",
                                    mini: true,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      207,
                                      65,
                                      65,
                                    ),
                                    onPressed: () {
                                      if (_currentPage > 0) {
                                        _goToPage(_currentPage - 1);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Right arrow
                                Positioned(
                                  right: 24,
                                  bottom: 24,
                                  child: FloatingActionButton(
                                    heroTag: "right",
                                    mini: true,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      207,
                                      65,
                                      65,
                                    ),
                                    onPressed: () {
                                      if (_currentPage < _slides.length - 1) {
                                        _goToPage(_currentPage + 1);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Dots indicator
                                Positioned(
                                  bottom: 28,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(_slides.length, (
                                        index,
                                      ) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          child: _DotIndicator(
                                            active: _currentPage == index,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Categories section (keyed)
                  Container(
                    key: _categoriesKey,
                    child: const PopularCategoriesSection(),
                  ),
                  // New Arrivals section
                  Container(
                    key: _newArrivalsKey,
                    child: const NewArrivalsSection(),
                  ),
                  // Featured Products section
                  Container(
                    key: _featuredKey,
                    child: const FeaturedProductsSection(),
                  ),
                  // Special Deals section
                  Container(key: _dealsKey, child: const SpecialDealsSection()),
                  // Brands section
                  Container(key: _brandsKey, child: const BrandsSection()),
                  // Testimonials section
                  Container(
                    key: _testimonialsKey,
                    child: const TestimonialsSection(),
                  ),
                  // Newsletter section
                  Container(
                    key: _newsletterKey,
                    child: const NewsletterSection(),
                  ),
                  // Footer section
                  Container(key: _footerKey, child: const FooterSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String) onItemSelected;
  const _CustomAppBar({required this.onItemSelected});
  @override
  Size get preferredSize => const Size.fromHeight(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 175, 106, 106).withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(size: 30, Icons.menu, color: Colors.black87),
            onPressed: () {},
          ),
          // LOGO (replace error text with your actual logo)
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: SizedBox(
              width: 60,
              height: 70,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.PNG',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Text(
                    'Unable to load asset: "assets/images/logo.png".\nThe asset does not exist or has empty data.',
                    style: TextStyle(fontSize: 8, color: Colors.red[900]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          // Search Bar
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          _NavMenu(onItemSelected: onItemSelected),
        ],
      ),
    );
  }
}

class _NavMenu extends StatelessWidget {
  final void Function(String) onItemSelected;
  const _NavMenu({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // List of menu items
    final navItems = [
      _NavMenuItem('Home', isActive: true, onTap: () => onItemSelected('Home')),
      _NavMenuItem('Categories', onTap: () => onItemSelected('Categories')),
      _NavMenuItem(
        'Deals & Offers',
        onTap: () => onItemSelected('Deals & Offers'),
      ),
      _NavMenuItem('Brands', onTap: () => onItemSelected('Brands')),
      _NavMenuItem('About Us', onTap: () => onItemSelected('About Us')),
    ];

    return Row(
      children: [
        ...navItems,
        // Cart icon
        Consumer<CartService>(
          builder: (context, cart, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    // TODO: Navigate to cart page
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cart: ${cart.totalQuantity} items'),
                      ),
                    );
                  },
                ),
                if (cart.totalQuantity > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          cart.totalQuantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // SignUp button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              'SignUp',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
        // Login button
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF8B8B),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text('Login', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ),
      ],
    );
  }
}

class _NavMenuItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onTap;
  const _NavMenuItem(this.title, {this.isActive = false, this.onTap});

  @override
  State<_NavMenuItem> createState() => _NavMenuItemState();
}

class _NavMenuItemState extends State<_NavMenuItem>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  bool _hovered = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.08).animate(_fadeAnim);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverDown(TapDownDetails details) {
    setState(() {
      _pressed = true;
      _animationController.forward();
    });
  }

  void _onHoverUp(TapUpDetails details) {
    setState(() {
      _pressed = false;
      _animationController.reverse();
    });
  }

  void _onTapCancel() {
    setState(() {
      _pressed = false;
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.isActive;
    final bool showHighlight = _hovered || _pressed || isActive;
    final Color highlightColor = const Color.fromARGB(
      255,
      212,
      111,
      111,
    ); // Light red

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovered = true;
          _animationController.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
          _animationController.reverse();
        });
      },
      child: GestureDetector(
        onTapDown: _onHoverDown,
        onTapUp: _onHoverUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnim.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: showHighlight
                    ? highlightColor.withOpacity(_fadeAnim.value)
                    : const Color.fromARGB(0, 215, 112, 112),
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
                child: Text(widget.title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final bool active;
  const _DotIndicator({this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 12 : 8,
      height: active ? 12 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HeroSlide {
  final String image;
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  const _HeroSlide({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    this.subtitleStyle = const TextStyle(fontSize: 18, color: Colors.white),
  });
}
