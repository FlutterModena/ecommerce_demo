import 'package:flutter/material.dart';

/// Widget che mostra un titolo di sezione.
class DetailSectionTitle extends StatelessWidget {
  const DetailSectionTitle({
    super.key,
    required this.title,
    this.fontSize = 15,
  });

  /// Il titolo da visualizzare.
  final String title;

  /// La dimensione del font.
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
