import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

/// Widget that displays images from either network URLs or local assets
class ProductImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  const ProductImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  bool get _isNetworkImage {
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Print image path
    if (kDebugMode) {
      print('ProductImage: Loading image from: $imagePath');
      print('ProductImage: Is network image: $_isNetworkImage');
      print('ProductImage: Image path length: ${imagePath.length}');
    }

    // Handle empty image path
    if (imagePath.isEmpty) {
      if (kDebugMode) {
        print('ProductImage: WARNING - Image path is empty!');
      }
      return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              'No image',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (_isNetworkImage) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        // Web-specific: Use cache and error handling
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            if (kDebugMode) {
              print('ProductImage: Image loaded synchronously');
            }
            return child;
          }
          if (frame != null) {
            if (kDebugMode) {
              print('ProductImage: Image frame loaded');
            }
            return child;
          }
          // Still loading
          return Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          if (kDebugMode) {
            print('ProductImage: ERROR loading network image!');
            print('ProductImage: URL: $imagePath');
            print('ProductImage: Error: $error');
            print('ProductImage: Error type: ${error.runtimeType}');
            print('ProductImage: StackTrace: $stackTrace');
          }
          return Container(
            width: width ?? double.infinity,
            height: height ?? 200,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 8),
                if (kDebugMode)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Image failed to load',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (kDebugMode && imagePath.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      imagePath.length > 50 ? '${imagePath.substring(0, 50)}...' : imagePath,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            if (kDebugMode) {
              print('ProductImage: Image loaded successfully');
            }
            return child;
          }
          return Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        // Add cache settings for better performance
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          if (kDebugMode) {
            print('ProductImage: Error loading asset: $error');
          }
          return Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: const Icon(
              Icons.music_note,
              color: Colors.grey,
              size: 40,
            ),
          );
        },
      );
    }
  }
}
