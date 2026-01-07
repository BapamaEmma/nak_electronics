// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nak_electronics/features/home/sections/categories.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/features/home/sections/brands.dart';
import 'package:nak_electronics/features/home/sections/new_arrivals.dart';
import 'package:nak_electronics/features/home/sections/featured_products.dart';
import 'package:nak_electronics/features/home/sections/special_deals.dart';
import 'package:nak_electronics/features/home/sections/explore_products.dart';
import 'package:nak_electronics/features/home/sections/cart_drawer.dart';
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
  final GlobalKey _exploreKey = GlobalKey();
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
      drawer: const _MainSideMenu(),
      endDrawer: const CartDrawer(),
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
              onSearchTap: () => _scrollToKey(_exploreKey),
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
              // SHEIN-style explore / catalog section
              Container(
                key: _exploreKey,
                child: const ExploreProductsSection(),
                  ),
                  // Categories section (keyed)
                  Container(
                    key: _categoriesKey,
                    child: const PopularCategoriesSection(),
                  ),
                  // New Arrivals section
                  Container(
                    key: _newArrivalsKey,
                    // child: const NewArrivalsSection(), // Uncomment when ready to use
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
  final VoidCallback onSearchTap;
  const _CustomAppBar({
    required this.onItemSelected,
    required this.onSearchTap,
  });
  @override
  Size get preferredSize => const Size.fromHeight(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: modern hamburger + logo
          Row(
            children: [
              const _ModernHamburgerButton(),
              const SizedBox(width: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: SizedBox(
              width: 60,
              height: 70,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.PNG',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
            ],
          ),
          // Center: navigation menu
          Expanded(
            child: Center(
              child: _NavMenu(onItemSelected: onItemSelected),
            ),
          ),
          // Right: search, wishlist, cart + auth buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search pill (scrolls to explore section)
              TextButton.icon(
                onPressed: onSearchTap,
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.search, size: 18),
                label: const Text(
                  'Search products',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Wishlist icon (placeholder)
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black87,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Wishlist coming soon'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
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
                          Scaffold.of(context).openEndDrawer();
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              'SignUp',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8B8B),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              elevation: 0,
            ),
            onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
          ),
        ),
      ],
          ),
        ],
      ),
    );
  }
}

/// Modern hamburger button with hover/press effects.
class _ModernHamburgerButton extends StatefulWidget {
  const _ModernHamburgerButton();

  @override
  State<_ModernHamburgerButton> createState() => _ModernHamburgerButtonState();
}

class _ModernHamburgerButtonState extends State<_ModernHamburgerButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = _isPressed
        ? Colors.black.withOpacity(0.20)
        : _isHovered
            ? Colors.black.withOpacity(0.12)
            : Colors.black.withOpacity(0.06);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapCancel: () => setState(() => _isPressed = false),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTap: () {
          final scaffoldState = Scaffold.maybeOf(context);
          if (scaffoldState != null) {
            scaffoldState.openDrawer();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 0.7,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 3-line hamburger icon
              SizedBox(
                width: 18,
                height: 14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLine(),
                    _buildLine(widthFactor: 0.8),
                    _buildLine(widthFactor: 0.6),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLine({double widthFactor = 1}) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: 2,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(999),
        ),
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
    final List<Widget> navItems = [
      _NavMenuItem('Home', isActive: true, onTap: () => onItemSelected('Home')),
      const SizedBox(width: 8),
      const _CategoriesMegaMenu(),
      const SizedBox(width: 8),
      _NavMenuItem(
        'Deals & Offers',
        onTap: () => onItemSelected('Deals & Offers'),
      ),
      const SizedBox(width: 8),
      _NavMenuItem('Brands', onTap: () => onItemSelected('Brands')),
      const SizedBox(width: 8),
      _NavMenuItem('About Us', onTap: () => onItemSelected('About Us')),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: navItems,
    );
  }
}

/// Left side main menu drawer for the hamburger button.
class _MainSideMenu extends StatelessWidget {
  const _MainSideMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF8B8B),
                    Color(0xFFB83B3B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Image.asset(
                          'assets/images/logo.PNG',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.music_note, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Naknaa Electronics',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Shop premium instruments, sound, lighting\nand studio gear in one place.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const _DrawerSectionHeader('Shop by category'),
                  const _DrawerItem(
                    imagePath: 'assets/images/guitar copy.png',
                    label: 'Guitars & Bass',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/keyboard copy.png',
                    label: 'Keyboards & Pianos',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/drum.png',
                    label: 'Drums & Percussion',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/headset.png',
                    label: 'Headphones & Monitors',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/microphone copy.png',
                    label: 'Microphones & Recording',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/speaker.png',
                    label: 'PA & Live Sound',
                  ),
                  const _DrawerItem(
                    imagePath: 'assets/images/light copy.png',
                    label: 'Lighting & Effects',
                  ),
                  const Divider(),
                  const _DrawerSectionHeader('Account & orders'),
                  const _DrawerItem(
                    icon: Icons.person_outline,
                    label: 'Sign in / Create account',
                  ),
                  const _DrawerItem(
                    icon: Icons.shopping_bag_outlined,
                    label: 'My orders',
                  ),
                  const _DrawerItem(
                    icon: Icons.favorite_border,
                    label: 'Wishlist',
                  ),
                  const Divider(),
                  const _DrawerSectionHeader('Contact & hours'),
                  const _DrawerItem(
                    icon: Icons.phone_in_talk,
                    label: 'Call: +233 24 000 0000',
                  ),
                  const _DrawerItem(
                    icon: Icons.email_outlined,
                    label: 'Email: info@naknaa-music.com',
                  ),
                  const _DrawerItem(
                    icon: Icons.location_on_outlined,
                    label: 'Location: Accra, Ghana',
                  ),
                  const _DrawerItem(
                    icon: Icons.schedule,
                    label: 'Mon–Sat: 7:00am – 5:00pm',
                  ),
                  const Divider(),
                  const _DrawerSectionHeader('Support'),
                  const _DrawerItem(
                    icon: Icons.help_outline,
                    label: 'Help & FAQs',
                  ),
                  const _DrawerItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'Contact Naknaa',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSectionHeader extends StatelessWidget {
  final String title;
  const _DrawerSectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String label;
  const _DrawerItem({
    this.icon,
    this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: imagePath != null
          ? SizedBox(
              width: 26,
              height: 26,
              child: Image.asset(
                imagePath!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            )
          : ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFFFF4B5C),
                  Color(0xFFFF6B8B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Icon(icon ?? Icons.error_outline, size: 26, color: Colors.white),
            ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: () {
        Navigator.of(context).maybePop();
      },
    );
  }
}

/// SHEIN-style "Categories" mega menu in the app bar.
class _CategoriesMegaMenu extends StatelessWidget {
  const _CategoriesMegaMenu();

  static const _categories = <String>[
    'Guitars & Bass',
    'Keyboard',
    'Drums & Percussion',
    'Headphones',
    'Microphones',
    'Amplifiers',
    'Mixers',
    'PA System & Live Sound',
    'Lighting & Effect',
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<String>(
        tooltip: 'Browse categories',
        position: PopupMenuPosition.under,
        offset: const Offset(0, 6),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<String>(
              enabled: false,
              child: Text(
                'Shop by Category',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const PopupMenuDivider(),
            ..._categories.map(
              (c) => PopupMenuItem<String>(
                value: c,
                child: Text(
                  c,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ];
        },
        onSelected: (_) {
          // For now, just scroll to the Categories section via callback.
          // The actual callback is wired through _NavMenuItem('Categories')
          // which still uses onItemSelected('Categories').
          final state = context.findAncestorStateOfType<_NaknaaHomePageState>();
          if (state != null) {
            state._scrollToKey(state._categoriesKey);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Categories',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
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
  bool _hovered = false;
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                widget.title,
                key: _textKey,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              Positioned(
                left: 0,
                bottom: -2,
                child: AnimatedBuilder(
                  animation: _widthAnimation,
                  builder: (context, child) {
                    final renderBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
                    final textWidth = renderBox?.size.width ?? 0;
                    return Container(
                      height: 1.5,
                      width: textWidth * _widthAnimation.value,
                      decoration: BoxDecoration(
                        color: _hovered ? Colors.black87 : Colors.transparent,
                        borderRadius: BorderRadius.circular(0.75),
                      ),
                    );
                  },
                ),
              ),
            ],
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
