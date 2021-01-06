import 'package:flutter/material.dart';
import 'package:operation_tips/operation_tips.dart';
import 'package:operation_tips/src/controllable_operation_tips.dart';

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
  final OperationTipsBuilder builder;

  /// Tips bubble popping direction.
  final TipsDirection direction;

  ///Tips bubble onTap.
  final VoidCallback onTap;

  ///Tips bubble text.
  final String tips;
  final TextStyle textStyle;
  ///tips bubble background color
  final Color color;

  OperationTips({
    Key key,
    @required this.child,
    this.builder = _defaultOperationTipsBuilder,
    this.direction = TipsDirection.top,
    this.tips,
    this.onTap,
    this.textStyle = const TextStyle(color: Colors.white),
    this.color = Colors.black,
  })  : assert(tips != null),
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
    operationTipsController = OperationTipsController(
      vsync: this,
      direction: widget.direction,
      delegate: DefaultTipsBubbleDelegate(
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.tips,
                style: widget.textStyle,
              ),
            ),
            onTap: widget.onTap,
          ),
    );
  }

  Widget get child => widget.child;

  @override
  Widget build(BuildContext context) {
    return ControllableOperationTips(
      child: builder(context, child, operationTipsController),
      operationTipsController: operationTipsController,
    );
  }

  @override
  void dispose() {
    operationTipsController.dispose();
    super.dispose();
  }
}
