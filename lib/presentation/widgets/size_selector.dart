import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selected = 0;

  final sizes = ["S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        sizes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => setState(() => selected = index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: selected == index ? Colors.black : Colors.grey.shade200,
              ),
              child: Text(
                sizes[index],
                style: TextStyle(
                  color: selected == index ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
