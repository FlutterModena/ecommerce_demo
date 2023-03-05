import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Widget che mostra un'immagine da un url.
/// Se l'immagine è già stata scaricata, viene mostrata dalla cache.
class CachedImage extends StatefulWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
  });

  /// L'url dell'immagine.
  final String imageUrl;

  /// Cache delle immagini.
  static Map<String, Uint8List> imageCache = <String, Uint8List>{};

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  Uint8List _imageBytes = Uint8List(0);
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  Future<void> _loadImage() async {
    if (CachedImage.imageCache.containsKey(widget.imageUrl)) {
      debugPrint('Image loaded from cache: ${widget.imageUrl}');
      setState(() {
        _isLoading = false;
        _hasError = false;
        _imageBytes = CachedImage.imageCache[widget.imageUrl]!;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(widget.imageUrl));
    if (!mounted) {
      if (response.statusCode == 200) {
        _saveImageBytes(
          response.bodyBytes,
          url: widget.imageUrl,
        );
      }
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _saveImageBytes(
          response.bodyBytes,
          url: widget.imageUrl,
        );
        _imageBytes = response.bodyBytes;
      });
      return;
    }

    setState(() {
      _hasError = true;
    });
  }

  void _saveImageBytes(Uint8List bytes, {required String url}) {
    CachedImage.imageCache[url] = bytes;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_hasError) {
      return const Center(
        child: Icon(Icons.error),
      );
    }

    return Image.memory(
      _imageBytes,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }
}
