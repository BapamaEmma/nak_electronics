import 'package:flutter/material.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Testimonial> _testimonials = [
    Testimonial(
      name: 'Kwame Asante',
      role: 'Professional Musician',
      content:
          'Naknaa Electronics has been my go-to store for all my musical equipment needs. Their selection is incredible and the quality is always top-notch. The customer service is exceptional!',
      rating: 5,
      avatar: 'assets/images/avatar1.jpg',
    ),
    Testimonial(
      name: 'Ama Osei',
      role: 'Music Producer',
      content:
          'I\'ve been shopping at Naknaa for over 3 years now. They always have the latest equipment and their prices are very competitive. Fast delivery and excellent after-sales support.',
      rating: 5,
      avatar: 'assets/images/avatar2.jpg',
    ),
    Testimonial(
      name: 'Kofi Mensah',
      role: 'Sound Engineer',
      content:
          'The team at Naknaa really knows their stuff. They helped me choose the perfect audio interface for my home studio. Great expertise and friendly service!',
      rating: 5,
      avatar: 'assets/images/avatar3.jpg',
    ),
    Testimonial(
      name: 'Akosua Frimpong',
      role: 'Music Teacher',
      content:
          'As a music teacher, I need reliable instruments for my students. Naknaa provides quality instruments at affordable prices. Highly recommended!',
      rating: 4,
      avatar: 'assets/images/avatar4.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll testimonials
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  void _autoScroll() {
    if (mounted) {
      final nextPage = (_currentPage + 1) % _testimonials.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 5), _autoScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
      child: Column(
        children: [
          const Text(
            'What Our Customers Say',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Don\'t just take our word for it - hear from our satisfied customers',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 48),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TestimonialCard(testimonial: _testimonials[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_testimonials.length, (index) {
              return Container(
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.red : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String role;
  final String content;
  final int rating;
  final String avatar;

  Testimonial({
    required this.name,
    required this.role,
    required this.content,
    required this.rating,
    required this.avatar,
  });
}

class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const TestimonialCard({super.key, required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quote icon
          const Icon(Icons.format_quote, size: 48, color: Color(0xFFFF8B8B)),
          const SizedBox(height: 16),
          // Testimonial content
          Text(
            testimonial.content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          // Rating stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < testimonial.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 24,
              );
            }),
          ),
          const SizedBox(height: 16),
          // Customer info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(testimonial.avatar),
                onBackgroundImageError: (exception, stackTrace) {},
                child: testimonial.avatar.isEmpty
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    testimonial.role,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



