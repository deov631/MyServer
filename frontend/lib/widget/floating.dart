import 'package:flutter/material.dart';

class MyFloatingContainer extends StatefulWidget {
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;
  final Offset offset;
  final double activeBlurRadius;
  final double activeSpreadRadius;
  final Offset activeOffset;
  final Duration duration;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget child;

  const MyFloatingContainer({
    super.key,
    this.shadowColor = Colors.black12,
    this.blurRadius = 2,
    this.spreadRadius = 0.5,
    this.offset = const Offset(1, 1),
    this.activeBlurRadius = 5.0,
    this.activeSpreadRadius = 1.0,
    this.activeOffset = const Offset(2, 2),
    this.duration = const Duration(milliseconds: 200),
    this.color,
    this.borderRadius,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _MyFloatingContainerState();
}

class _MyFloatingContainerState extends State<MyFloatingContainer> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              blurRadius: _isHovering
                  ? widget.activeBlurRadius
                  : widget.blurRadius,
              spreadRadius: _isHovering
                  ? widget.activeSpreadRadius
                  : widget.spreadRadius,
              offset: _isHovering ? widget.activeOffset : widget.offset,
            ),
          ],
        ),
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

class MyFloatingCard extends StatefulWidget {
  final double height;
  final String title;
  final TextStyle titleStyle;
  final Color color1;
  final Color color2;
  final Widget? child;
  final VoidCallback? onTap;

  const MyFloatingCard({
    super.key,
    this.height = 150,
    required this.title,
    this.titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    required this.color1,
    required this.color2,
    this.onTap,
    this.child,
  });

  @override
  State<StatefulWidget> createState() => _MyFloatingCardState();
}

class _MyFloatingCardState extends State<MyFloatingCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEvent event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (PointerEvent event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap ?? () {
          debugPrint("Tapped ${widget.title}");
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          height: widget.height - 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.color1, widget.color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _isHovering ? Colors.black26 : Colors.black12,
                blurRadius: _isHovering ? 5.0 : 2.0,
                spreadRadius: _isHovering ? 1.0 : 0.5,
                offset: _isHovering ? Offset(2, 2) : Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                  Spacer(),
                ],
              ),
              if (widget.child != null) widget.child!,
            ],
          ),
        ),
      ),
    );
  }
}
