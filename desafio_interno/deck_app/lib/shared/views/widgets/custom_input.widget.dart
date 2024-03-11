import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final int _maxLines;

  const CustomInput({
    super.key,
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  })  : _controller = controller,
        _label = label,
        _maxLines = maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _label,
      ),
      maxLines: _maxLines,
    );
  }
}
