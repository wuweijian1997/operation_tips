import 'package:flutter/material.dart';
import 'package:operation_tips/operation_tips.dart';

class OperationTipsController {
  BuildContext _context;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;
  final TipsBubbleDelegate delegate;
  final TipsDirection direction;

  Animation<double> get animation => _animationController?.view;

  bool get isActive => _overlayEntry != null;

  set context(value) {
    _context = value;
  }

  OperationTipsController({
    @required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 200),
    @required this.delegate,
    this.direction = TipsDirection.top,
  }) {
    _animationController =
        AnimationController(vsync: vsync, duration: duration);
  }

  close({bool isAnimated = true}) async {
    if (_overlayEntry == null) return;
    if (isAnimated == true) {
      await _animationController.reverse();
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  open() {
    if (_overlayEntry != null) return;
    assert(_context != null);
    RenderBox renderBox = _context.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(builder: (_) {
      return delegate.build(_context, size, offset, direction, this);
    });
    Overlay.of(_context).insert(_overlayEntry);
    _animationController?.forward();
  }

  dispose() {
    close(isAnimated: false);
    _animationController.dispose();
  }
}
