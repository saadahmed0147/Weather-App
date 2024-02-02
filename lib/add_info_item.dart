import 'package:flutter/material.dart';
import 'package:weather_app/colors.dart';

class AddInfoItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String data;

  const AddInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.data,
  });

  @override
  State<AddInfoItem> createState() => _AddInfoItemState();
}

class _AddInfoItemState extends State<AddInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              widget.icon,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(color: greyColor),
            ),
            const SizedBox(height: 8),
            Text(
              widget.data,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
