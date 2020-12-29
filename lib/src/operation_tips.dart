import 'package:flutter/material.dart';
import 'package:operation_tips/operation_tips.dart';

typedef OperationTipsBuilder = Widget Function(
  BuildContext context,
  Widget child,
  OperationTipsController operationTipsController,
);

Widget _defaultOperationTipsBuilder(
  BuildContext context,
  Widget child,
  OperationTipsController operationTipsController,
) {
  return WillPopScope(
    onWillPop: () {
      if (operationTipsController.isActive) {
        operationTipsController.close();
        return Future.value(false);
      }
      return Future.value(true);
    },
    child: GestureDetector(
      child: child,
      onLongPress: () {
        operationTipsController.open();
      },
    ),
  );
}

class OperationTips extends StatefulWidget {
  final Widget child;
  final OperationTipsController operationTipsController;
  final OperationTipsBuilder builder;
  final TipsDirection direction;
  ///tips bubble onTap
  final VoidCallback onTap;
  final String title;
  final TipsBubbleDelegate delegate;
  ///tips bubble background color
  final Color color;

  OperationTips({
    Key key,
    @required this.child,
    this.operationTipsController,
    this.builder = _defaultOperationTipsBuilder,
    this.direction = TipsDirection.top,
    this.title,
    this.onTap,
    this.delegate,
    this.color = Colors.black,
  })  : assert(operationTipsController != null || title != null || delegate != null),
        super(key: key);

  @override
  _OperationTipsState createState() => _OperationTipsState();
}

class _OperationTipsState extends State<OperationTips>
    with SingleTickerProviderStateMixin {
  OperationTipsController operationTipsController;
  Animation<double> scale;
  Animation<double> opacity;
  Size size = Size.zero;

  OperationTipsBuilder get builder => widget.builder;

  @override
  void initState() {
    super.initState();
    operationTipsController = widget.operationTipsController ??
        OperationTipsController(
          vsync: this,
          direction: widget.direction,
          delegate: widget.delegate ?? DefaultTipsBubbleDelegate(
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: widget.onTap,
          ),
        );
  }

  Widget get child => widget.child;

  @override
  Widget build(BuildContext context) {
    assert(child != null);
    if (operationTipsController._context == null) {
      operationTipsController._context = context;
    }
    return builder(context, child, operationTipsController);
  }

  @override
  void dispose() {
    operationTipsController.dispose();
    super.dispose();
  }
}

class OperationTipsController {
  BuildContext _context;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;
  final TipsBubbleDelegate delegate;
  final TipsDirection direction;

  Animation<double> get animation => _animationController?.view;

  bool get isActive => _overlayEntry != null;

  OperationTipsController({
    @required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 200),
    @required this.delegate,
    this.direction = TipsDirection.top,
  }) {
    if (vsync != null) {
      _animationController =
          AnimationController(vsync: vsync, duration: duration);
    }
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
