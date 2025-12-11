import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(Icons.remove, () {
          if (count > 1) setState(() => count--);
        }),
        const SizedBox(width: 16),
        Text(count.toString(), style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 16),
        _buildButton(Icons.add, () => setState(() => count++)),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: IconButton(icon: Icon(icon, size: 22), onPressed: onTap),
    );
  }
}
