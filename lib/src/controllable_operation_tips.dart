import 'package:flutter/material.dart';
import 'package:operation_tips/operation_tips.dart';

class ControllableOperationTips extends StatelessWidget {
  final Widget child;
  final OperationTipsController operationTipsController;

  ControllableOperationTips({
    Key key,
    @required this.child,
    @required this.operationTipsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    operationTipsController.context = context;
    return child;
  }
}
