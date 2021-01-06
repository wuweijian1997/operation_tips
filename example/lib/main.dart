import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:operation_tips/operation_tips.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  OperationTipsController operationTipsController;

  @override
  void initState() {
    super.initState();
    operationTipsController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.top,
      delegate: DefaultTipsBubbleDelegate(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => onTap('Top'),
      ),
    );
  }

  onTap(String title) {
    print("$title was clicked!");
  }

  buildOperationTips(
      {String text,
      Color color,
      TextStyle textStyle,
      TipsDirection direction}) {
    return OperationTips(
      onTap: () {
        onTap(text);
      },
      color: color,
      tips: text,
      textStyle: textStyle,
      direction: direction,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: ControllableOperationTips(
                operationTipsController: operationTipsController,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text("Center"),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 50,
              child: buildOperationTips(
                text: 'Top',
                textStyle: TextStyle(color: Colors.blue),
                direction: TipsDirection.top,
                color: Colors.redAccent,
              ),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: buildOperationTips(
                text: 'Left',
                textStyle: TextStyle(color: Colors.red),
                direction: TipsDirection.left,
                color: Colors.blueAccent,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: buildOperationTips(
                text: 'Right',
                textStyle: TextStyle(color: Colors.white),
                direction: TipsDirection.right,
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 100,
              right: 50,
              child: buildOperationTips(
                text: 'Bottom',
                textStyle: TextStyle(color: Colors.yellow),
                direction: TipsDirection.bottom,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          operationTipsController.open();
        },
      ),
    );
  }
}
