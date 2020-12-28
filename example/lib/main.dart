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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  OperationTipsController topController;
  OperationTipsController bottomController;
  OperationTipsController leftController;
  OperationTipsController rightController;

  @override
  void initState() {
    super.initState();
    topController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.vertical,
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
    bottomController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.top,
      delegate: DefaultTipsBubbleDelegate(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => onTap('Bottom'),
      ),
    );
    leftController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.horizontal,
      delegate: DefaultTipsBubbleDelegate(
        color: Colors.pink,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => onTap('Left'),
      ),
    );
    rightController = OperationTipsController(
      vsync: this,
      direction: TipsDirection.horizontal,
      delegate: DefaultTipsBubbleDelegate(
        color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hello world",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => onTap('Right'),
      ),
    );
  }

  onTap(String title) {
    print("$title was clicked!");
  }

  buildOperationTips(OperationTipsController controller, String text) {
    return OperationTips(
      operationTipsController: controller,
      onTap: () {
        onTap(text);
      },
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
              child: OperationTips(
                onTap: () {
                  onTap('Center');
                },
                title: "Title",
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
              top: 30,
              left: 50,
              child: buildOperationTips(bottomController, 'Bottom'),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: buildOperationTips(leftController, 'Left'),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: buildOperationTips(rightController, 'Right'),
            ),
            Positioned(
              bottom: 50,
              right: 50,
              child: buildOperationTips(topController, 'Top'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          topController.open();
          bottomController.open();
          leftController.open();
          rightController.open();
        },
      ),
    );
  }
}
