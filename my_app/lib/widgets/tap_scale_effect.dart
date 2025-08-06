import 'package:flutter/material.dart';

class TapScaleEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const TapScaleEffect({required this.child, required this.onTap});

  @override
  _TapScaleEffectState createState() => _TapScaleEffectState();
}

class _TapScaleEffectState extends State<TapScaleEffect> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.85);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: Duration(milliseconds: 50),
        scale: _scale,
        curve: Curves.easeOutExpo,
        child: widget.child,
      ),
    );
  }
}
