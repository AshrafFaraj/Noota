import 'package:flutter/material.dart';

class NoteImage extends StatelessWidget {
  const NoteImage({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Image.network(imageUrl,
          key: ValueKey(imageUrl),
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image)),
    );
  }
}
