import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<Home> {
  bool isFirst = true;

  FocusNode focusNodetwo;
  FocusNode focusNodeOne;
  FocusNode focusNodeZero;
  FocusNode inFocus;
  List<FocusNode> nodesList = List<FocusNode>(3);

  @override
  void initState() {
    super.initState();
    print("initializing");

    focusNodeZero = FocusNode();
    focusNodeOne = FocusNode();
    focusNodetwo = FocusNode();
    inFocus = FocusNode();
    nodesList = [focusNodeZero, focusNodeOne, focusNodetwo];
    nodesList[0].addListener(_changeColor2);
    nodesList[1].addListener(_changeColor2);
    nodesList[2].addListener(_changeColor2);
  }

  _changeColor2() {
    inFocus = nodesList.firstWhere((ele) {
      if (ele.hasFocus) {
        return true;
      } else {
        return false;
      }
    });
    print("focusNode.hasFocus = ${nodesList.indexOf(inFocus)}");
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onKeyBoardEvent(RawKeyEvent event) {
    FocusNode requestingNode = FocusNode();
    if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
      print('keydown');
      RawKeyDownEvent ev = event;
      RawKeyEventDataAndroid evAndroid = ev.data;
      if(evAndroid.keyCode == 20){
      if(nodesList.last == inFocus){
        requestingNode = nodesList.first;
        inFocus = requestingNode;
      }
      else{
        requestingNode = nodesList[nodesList.indexOf(inFocus)+1];
        inFocus = requestingNode;
      }
      FocusScope.of(context).requestFocus(requestingNode);
      print(evAndroid.keyCode);
    } else if(evAndroid.keyCode == 19){
      if(nodesList.first == inFocus){
        requestingNode = nodesList.last;
        inFocus = requestingNode;
      }
      else{
        requestingNode = nodesList[nodesList.indexOf(inFocus)-1];
        inFocus = requestingNode;
      }
      FocusScope.of(context).requestFocus(requestingNode);
      print(evAndroid.keyCode);
    }else{
      print('another keypressed');
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    if (isFirst) {
      FocusScope.of(context).requestFocus(focusNodeZero);
      isFirst = false;
    }

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
      RawKeyboardListener(
        child: DecoratedBox(
          child: Text('first Box'),
          decoration: BoxDecoration(
              color: nodesList[0].hasFocus ? Colors.grey : Colors.transparent),
        ),
        focusNode: nodesList[0],
        onKey: onKeyBoardEvent
        ,
      ),
      RawKeyboardListener(
        child: DecoratedBox(
          child: Text('second Box'),
          decoration: BoxDecoration(
              color: nodesList[1].hasFocus ? Colors.grey : Colors.transparent),
        ),
        focusNode: nodesList[1],
        onKey: onKeyBoardEvent,
      ),
      RawKeyboardListener(
        child: DecoratedBox(
          child: Text('third Box'),
          decoration: BoxDecoration(
              color: nodesList[2].hasFocus ? Colors.grey : Colors.transparent),
        ),
        focusNode: nodesList[2],
        onKey: onKeyBoardEvent,
      ),
    ]));
  }
}
