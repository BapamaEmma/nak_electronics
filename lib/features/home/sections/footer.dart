import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF050816),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              // Top: brand + columns
          LayoutBuilder(
            builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;

                  final brandColumn = Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                              width: 56,
                              height: 56,
                                    decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                    ),
                                    child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                  'assets/images/logo.PNG',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Naknaa Electronics',
                                    style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 12),
                              const Text(
                          'Premium instruments, sound and lighting gear for studios,\nchurches, events and creators across Ghana.',
                                style: TextStyle(
                            fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _SocialIcon.image('assets/images/Watup.png', () {}),
                            _SocialIcon.image('assets/images/youtube.png', () {}),
                            _SocialIcon.image('assets/images/TikTok.png', () {}),
                          ],
                        ),
                            ],
                          ),
                  );

                  final shopColumn = Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                          'Shop',
                                style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                                  color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _FooterLink('Guitars & Bass', () {}),
                        _FooterLink('Keyboards & Pianos', () {}),
                        _FooterLink('Drums & Percussion', () {}),
                        _FooterLink('Studio & Recording', () {}),
                        _FooterLink('PA & Live Sound', () {}),
                        _FooterLink('Lighting & FX', () {}),
                      ],
                    ),
                  );

                  final helpColumn = Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                          'Help',
                                style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                                  color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _FooterLink('Orders & Shipping', () {}),
                        _FooterLink('Returns & Refunds', () {}),
                        _FooterLink('Warranty', () {}),
                        _FooterLink('FAQs', () {}),
                        _FooterLink('Contact support', () {}),
                      ],
                    ),
                  );

                  final contactColumn = Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Visit us',
                                style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                        SizedBox(height: 12),
                              _ContactItem(
                          Icons.location_on_outlined,
                                'Accra, Ghana\nEast Legon, ARS Building',
                              ),
                        SizedBox(height: 10),
                              _ContactItem(
                          Icons.phone_in_talk_outlined,
                                '+233 24 123 4567\n+233 20 987 6543',
                              ),
                        SizedBox(height: 10),
                              _ContactItem(
                          Icons.email_outlined,
                          'info@naknaaelectronics.com',
                              ),
                        SizedBox(height: 10),
                              _ContactItem(
                          Icons.schedule_outlined,
                          'Mon – Sat: 7:00 am – 5:00 pm',
                        ),
                      ],
                    ),
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        brandColumn,
                        const SizedBox(width: 40),
                        shopColumn,
                        const SizedBox(width: 24),
                        helpColumn,
                        const SizedBox(width: 24),
                        contactColumn,
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      brandColumn,
                      const SizedBox(height: 32),
                      shopColumn,
                      const SizedBox(height: 24),
                      helpColumn,
                      const SizedBox(height: 24),
                      contactColumn,
                      ],
                    );
            },
          ),
              const SizedBox(height: 28),
              // Thin divider
              Container(
                height: 1,
                color: Colors.white24,
              ),
              const SizedBox(height: 18),
              // Bottom bar: copyright + policies + payments
          LayoutBuilder(
            builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;

                  final copyrightText =
                      const Text('© 2024 Naknaa Electronics. All rights reserved.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ));

                  final policyRow = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _FooterLink('Privacy', () {}, isSmall: true),
                      const SizedBox(width: 8),
                      _FooterLink('Terms', () {}, isSmall: true),
                      const SizedBox(width: 8),
                      _FooterLink('Cookies', () {}, isSmall: true),
                    ],
                  );

                  final paymentsRow = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _PaymentImageIcon('assets/images/momo.png'),
                      _PaymentImageIcon('assets/images/telcel.png'),
                    ],
                  );

                  if (isWide) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            copyrightText,
                            const SizedBox(width: 16),
                            policyRow,
                          ],
                        ),
                        paymentsRow,
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                      copyrightText,
                      const SizedBox(height: 8),
                      policyRow,
                const SizedBox(height: 12),
                      paymentsRow,
                    ],
                  );
                },
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _SocialIcon.image(this.imagePath, this.onTap);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Colors.white24,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Center(
              child: Image.asset(
                widget.imagePath,
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(width: 26, height: 26);
                },
              ),
            ),
          ),
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
            decoration: TextDecoration.none,
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

class _PaymentImageIcon extends StatelessWidget {
  final String assetPath;

  const _PaymentImageIcon(this.assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Image.asset(
        assetPath,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}
