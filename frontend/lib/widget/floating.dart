import 'package:flutter/material.dart';

class FloatingCard extends StatefulWidget {
  final Color? color;
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;
  final Offset offset;
  final double activeBlurRadius;
  final double activeSpreadRadius;
  final Offset activeOffset;
  final Duration duration;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;
  const FloatingCard({
    super.key,
    this.color,
    this.shadowColor = Colors.black38,
    this.blurRadius = 2,
    this.spreadRadius = 1,
    this.offset = const Offset(1, 2),
    this.activeBlurRadius = 3,
    this.activeSpreadRadius = 2,
    this.activeOffset = const Offset(2, 4),
    this.duration = const Duration(milliseconds: 200),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.margin = const EdgeInsets.all(0),
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard> {

  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).cardColor,
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              blurRadius: _isHovering ? widget.activeBlurRadius : widget.blurRadius,
              spreadRadius: _isHovering ? widget.activeSpreadRadius : widget.spreadRadius,
              offset: _isHovering ? widget.activeOffset : widget.offset,
            ),
          ],
        ),
        padding: widget.padding,
        margin: widget.margin,
        child: widget.child,
      ),
    );
  }

  Future<void> _onEnter(PointerEvent event) async {
    setState(() {
      _isHovering = true;
    });
  }

  Future<void> _onExit(PointerEvent event) async {
    setState(() {
      _isHovering = false;
    });
  }
}