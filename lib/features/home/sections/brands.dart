import 'package:flutter/material.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  final List<Map<String, dynamic>> _brandLogos = const [
    {'name': 'Ibanez', 'path': 'assets/images/ibanez.png'},
    {'name': 'Fender', 'path': 'assets/images/fender.png'},
    {'name': 'Gibson', 'path': 'assets/images/gibson.png'},
    {'name': 'Yamaha', 'path': 'assets/images/yamaha.png'},
    {'name': 'EV', 'path': 'assets/images/ev.png'},
    {'name': 'JBL', 'path': 'assets/images/jbl.png'},
    {'name': 'Pearl', 'path': 'assets/images/pearl.png'},
    {'name': 'TAMA', 'path': 'assets/images/tama.png'},
    {'name': 'MG Series', 'path': 'assets/images/mg_series.png'},
    {'name': 'Shure', 'path': 'assets/images/shure.png'},
    {'name': 'Line Arrays', 'path': 'assets/images/line_arrays.png'},
    {'name': 'Light', 'path': 'assets/images/light.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        const Text(
          'Product Brands',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 6,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: _brandLogos.map((brand) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/products',
                    arguments: {
                      'filterType': 'brand',
                      'filterValue': brand['name'],
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF0DCDC),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: ClipOval(
                        child: Image.asset(
                          brand['path'],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      brand['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 48),

        const SizedBox(height: 48),
      ],
    );
  }
}
