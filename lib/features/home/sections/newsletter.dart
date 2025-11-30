import 'package:flutter/material.dart';

class NewsletterSection extends StatefulWidget {
  const NewsletterSection({super.key});

  @override
  State<NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<NewsletterSection> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSubscribed = false;

  void _subscribe() {
    if (_emailController.text.isNotEmpty &&
        _emailController.text.contains('@')) {
      setState(() {
        _isSubscribed = true;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully subscribed to our newsletter!'),
          backgroundColor: Colors.green,
        ),
      );

      // Reset after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isSubscribed = false;
            _emailController.clear();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 19, 13, 10),
            Color.fromARGB(255, 218, 216, 214),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 800
              ? Row(
                  children: [
                    // Left side - Content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Stay Updated with Naknaa',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Subscribe to our newsletter and be the first to know about:',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _BenefitItem(
                                text: 'New product arrivals and launches',
                              ),
                              _BenefitItem(
                                text: 'Exclusive deals and special offers',
                              ),
                              _BenefitItem(
                                text: 'Music industry news and tips',
                              ),
                              _BenefitItem(
                                text: 'Early access to sales and events',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Right side - Subscription form
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Join Our Newsletter',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Get exclusive updates delivered to your inbox',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            if (!_isSubscribed) ...[
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your email address',
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF667eea),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _subscribe,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF667eea),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Subscribe Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ] else ...[
                              const Icon(
                                Icons.check_circle,
                                size: 64,
                                color: Colors.green,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Thank You!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'You\'ve successfully subscribed to our newsletter.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            const SizedBox(height: 16),
                            const Text(
                              'We respect your privacy. Unsubscribe at any time.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    // Left side - Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Stay Updated with Naknaa',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Subscribe to our newsletter and be the first to know about:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BenefitItem(
                              text: 'New product arrivals and launches',
                            ),
                            _BenefitItem(
                              text: 'Exclusive deals and special offers',
                            ),
                            _BenefitItem(text: 'Music industry news and tips'),
                            _BenefitItem(
                              text: 'Early access to sales and events',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Right side - Subscription form
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Join Our Newsletter',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Get exclusive updates delivered to your inbox',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          if (!_isSubscribed) ...[
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter your email address',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _subscribe,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF667eea),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Subscribe Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            const Icon(
                              Icons.check_circle,
                              size: 64,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Thank You!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You\'ve successfully subscribed to our newsletter.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 16),
                          const Text(
                            'We respect your privacy. Unsubscribe at any time.',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
