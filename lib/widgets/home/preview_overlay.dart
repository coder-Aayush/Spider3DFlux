import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstore/common/theme/colors.dart';

class PreviewOverlay extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? config;
  final builder;

  PreviewOverlay({
    this.index,
    this.config,
    required this.builder,
  }) : assert(builder != null);

  @override
  _PreviewOverlayState createState() => _PreviewOverlayState();
}

class _PreviewOverlayState extends State<PreviewOverlay> {
  @override
  Widget build(BuildContext context) {
    bool isPreviewing = widget.config!['isPreviewing'] ?? false;
    var colorPreview = [
      Colors.deepOrange,
      Colors.cyanAccent,
      Colors.deepPurple,
      Colors.pink,
      Colors.lightGreen,
      Colors.amber,
      Colors.indigoAccent,
      kColorSpiderRed.withOpacity(0.70),
      Colors.teal,
    ];

    return Stack(
      key: widget.config!['key'] != null
          ? Key('overlay_${widget.config!['key']}')
          : null,
      children: [
        widget.builder(widget.config),
        if (isPreviewing)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isPreviewing
                      ? colorPreview[widget.index! % colorPreview.length]
                          .withOpacity(0.1)
                      : Colors.transparent,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
