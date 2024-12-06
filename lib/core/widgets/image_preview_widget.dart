import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImagePreview extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration cacheDuration;
  final bool enableMemoryCache;

  const ImagePreview({
    Key? key,
    this.imageUrl,
    this.imageFile,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.cacheDuration = const Duration(days: 7),
    this.enableMemoryCache = true,
  }) : assert(imageUrl != null || imageFile != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Preview'),),
      backgroundColor: Colors.black,
      body: Center(
        // width: width,
        // height: height,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorWidget(error.toString()),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWidget(error.toString()),
      cacheManager: CacheManager(
        Config(
          'imagePreviewCache',
          stalePeriod: cacheDuration,
          maxNrOfCacheObjects: 100,
          repo: JsonCacheInfoRepository(databaseName: 'imagePreviewCache'),
        ),
      ),
      memCacheWidth: enableMemoryCache ? (width?.toInt()) : null,
      memCacheHeight: enableMemoryCache ? (height?.toInt()) : null,
    );
  }

  Widget _buildPlaceholder() {
    return placeholder ?? const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget(String error) {
    return errorWidget ?? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(height: 8),
          Text(
            'Failed to load image\n$error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}