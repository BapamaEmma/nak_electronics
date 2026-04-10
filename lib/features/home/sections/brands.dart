import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandsSection extends StatefulWidget {
  const BrandsSection({super.key});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> {
  List<Map<String, dynamic>> _brands = [];
  bool _isLoading = true;
  StreamSubscription? _subscription;
  DateTime? _loadingStart;

  @override
  void initState() {
    super.initState();
    _loadingStart = DateTime.now();
    _subscription = FirebaseFirestore.instance
        .collection('brands')
        .orderBy('order')
        .snapshots()
        .listen(
      (snap) {
        setState(() {
          _brands = snap.docs
              .map((d) => {'name': d['name'], 'logoUrl': d['logoUrl']})
              .toList();
        });
        final elapsed = DateTime.now().difference(_loadingStart!).inMilliseconds;
        final remaining = 1500 - elapsed;
        if (remaining > 0) {
          Future.delayed(Duration(milliseconds: remaining), () {
            if (mounted) setState(() { _isLoading = false; });
          });
        } else {
          setState(() { _isLoading = false; });
        }
      },
      onError: (_) => setState(() => _isLoading = false),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

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
        if (_isLoading)
          Shimmer.fromColors(
            baseColor: const Color(0xFFE0E0E0),
            highlightColor: Colors.white,
            period: const Duration(milliseconds: 2500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 6,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                children: List.generate(12, (_) => _ShimmerBrandCard()),
              ),
            ),
          )
        else if (_brands.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text('No brands yet.', style: TextStyle(color: Colors.grey)),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 6,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _brands.map((brand) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
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
                            child: Image.network(
                              brand['logoUrl'] ?? '',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.music_note),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      brand['name'] ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        const SizedBox(height: 48),
      ],
    );
  }
}

class _ShimmerBrandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE0E0E0),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(height: 10, width: 60, color: const Color(0xFFE0E0E0)),
      ],
    );
  }
}
