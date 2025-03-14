import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;

  const QuantitySelector({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
  });

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onChanged(_quantity);
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onChanged(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(icon: Icons.remove, onPressed: _decrement),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 108, // Chiều dài (rộng ngang)
          height: 36, // Chiều rộng (cao dọc)
          child: Container(
            alignment: Alignment.center, // Căn giữa số lượng
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE1001A), width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              '$_quantity',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE1001A),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        _buildButton(icon: Icons.add, onPressed: _increment),
      ],
    );
  }

  Widget _buildButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.red),
      ),
    );
  }
}
