import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2C3E50),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main footer content
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 1000
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company info
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo and company name
                              Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/logo.png', // Update path as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Naknaa Electronics',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Your trusted partner for premium musical instruments and audio equipment. We\'ve been serving musicians and audio professionals for over a decade.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Social media icons
                              const Text(
                                'Follow Us',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _SocialIcon(Icons.facebook, () {}),
                                  _SocialIcon(
                                    Icons.camera_alt,
                                    () {},
                                  ), // Instagram
                                  _SocialIcon(
                                    Icons.alternate_email,
                                    () {},
                                  ), // Twitter
                                  _SocialIcon(
                                    Icons.video_library,
                                    () {},
                                  ), // YouTube
                                  _SocialIcon(
                                    Icons.business,
                                    () {},
                                  ), // LinkedIn
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                        // Quick links
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Quick Links',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _FooterLink('Home', () {}),
                              _FooterLink('Categories', () {}),
                              _FooterLink('Brands', () {}),
                              _FooterLink('New Arrivals', () {}),
                              _FooterLink('Special Offers', () {}),
                              _FooterLink('About Us', () {}),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                        // Customer service
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Customer Service',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _FooterLink('Contact Us', () {}),
                              _FooterLink('FAQ', () {}),
                              _FooterLink('Shipping Info', () {}),
                              _FooterLink('Returns & Exchanges', () {}),
                              _FooterLink('Warranty', () {}),
                              _FooterLink('Support Center', () {}),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                        // Contact info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact Info',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _ContactItem(
                                Icons.location_on,
                                'Accra, Ghana\nEast Legon, ARS Building',
                              ),
                              const SizedBox(height: 12),
                              _ContactItem(
                                Icons.phone,
                                '+233 24 123 4567\n+233 20 987 6543',
                              ),
                              const SizedBox(height: 12),
                              _ContactItem(
                                Icons.email,
                                'info@naknaaelectronics.com\nsupport@naknaaelectronics.com',
                              ),
                              const SizedBox(height: 12),
                              _ContactItem(
                                Icons.access_time,
                                'Mon - Fri: 8:00 AM - 6:00 PM\nSat: 9:00 AM - 4:00 PM',
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo and company name
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF8B8B),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/images/logo.png', // Update path as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Naknaa Electronics',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Your trusted partner for premium musical instruments and audio equipment. We\'ve been serving musicians and audio professionals for over a decade.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Social media icons
                            const Text(
                              'Follow Us',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _SocialIcon(Icons.facebook, () {}),
                                _SocialIcon(
                                  Icons.camera_alt,
                                  () {},
                                ), // Instagram
                                _SocialIcon(
                                  Icons.alternate_email,
                                  () {},
                                ), // Twitter
                                _SocialIcon(
                                  Icons.video_library,
                                  () {},
                                ), // YouTube
                                _SocialIcon(Icons.business, () {}), // LinkedIn
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Quick links
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quick Links',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _FooterLink('Home', () {}),
                            _FooterLink('Categories', () {}),
                            _FooterLink('Brands', () {}),
                            _FooterLink('New Arrivals', () {}),
                            _FooterLink('Special Offers', () {}),
                            _FooterLink('About Us', () {}),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Customer service
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Customer Service',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _FooterLink('Contact Us', () {}),
                            _FooterLink('FAQ', () {}),
                            _FooterLink('Shipping Info', () {}),
                            _FooterLink('Returns & Exchanges', () {}),
                            _FooterLink('Warranty', () {}),
                            _FooterLink('Support Center', () {}),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Contact info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Info',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _ContactItem(
                              Icons.location_on,
                              'Accra, Ghana\nEast Legon, ARS Building',
                            ),
                            const SizedBox(height: 12),
                            _ContactItem(
                              Icons.phone,
                              '+233 24 123 4567\n+233 20 987 6543',
                            ),
                            const SizedBox(height: 12),
                            _ContactItem(
                              Icons.email,
                              'info@naknaaelectronics.com\nsupport@naknaaelectronics.com',
                            ),
                            const SizedBox(height: 12),
                            _ContactItem(
                              Icons.access_time,
                              'Mon - Fri: 8:00 AM - 6:00 PM\nSat: 9:00 AM - 4:00 PM',
                            ),
                          ],
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 48),
          // Divider
          Container(height: 1, color: Colors.white24),
          const SizedBox(height: 24),
          // Bottom footer
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 600
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '© 2024 Naknaa Electronics. All rights reserved.',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        Row(
                          children: [
                            _FooterLink('Privacy Policy', () {}, isSmall: true),
                            const Text(
                              ' | ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            _FooterLink(
                              'Terms of Service',
                              () {},
                              isSmall: true,
                            ),
                            const Text(
                              ' | ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            _FooterLink('Cookie Policy', () {}, isSmall: true),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          '© 2024 Naknaa Electronics. All rights reserved.',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _FooterLink('Privacy Policy', () {}, isSmall: true),
                            const Text(
                              ' | ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            _FooterLink(
                              'Terms of Service',
                              () {},
                              isSmall: true,
                            ),
                            const Text(
                              ' | ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            _FooterLink('Cookie Policy', () {}, isSmall: true),
                          ],
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 24),
          // Payment methods
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'We Accept',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _PaymentIcon('Visa'),
                    _PaymentIcon('Mastercard'),
                    _PaymentIcon('MTN Mobile Money'),
                    _PaymentIcon('Vodafone Cash'),
                    _PaymentIcon('AirtelTigo Money'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon(this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSmall;

  const _FooterLink(this.text, this.onTap, {this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmall ? 0 : 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            color: Colors.white70,
            decoration: TextDecoration.underline,
            decorationColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFFFF8B8B), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentIcon extends StatelessWidget {
  final String name;

  const _PaymentIcon(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
