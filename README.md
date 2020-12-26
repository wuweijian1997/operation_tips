# operation_tips

Flutter operation tips.Flutter 长按弹出,操作提示.

## Getting Started

```
dependencies:
  operation_tips: ^0.0.1
```
## Example
simple.
```
OperationTips(
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
```

Use `OperationTipsController`
```
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  OperationTipsController controller;

  @override
    void initState() {
      super.initState();
      controller = OperationTipsController(
        vsync: this,
        direction: TipsDirection.vertical,
        delegate: DefaultTipsBubbleDelegate(
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
}
```
![demo.jpg](https://github.com/wuweijian1997/operation_tips/blob/main/example/demo.jpg)