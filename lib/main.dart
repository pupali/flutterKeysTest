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
        ),);

 }
}


      class Home extends StatefulWidget{
        @override
        State<StatefulWidget> createState() {
            return MyAppState();
          }
      }
class MyAppState extends State<Home> {
  FocusNode focusNodetwo;

  @override
  void initState() {
    super.initState();
    print("initializing");
    focusNodetwo = new FocusNode();

    focusNodetwo.addListener(_changeColor2);
  }

  _changeColor2() {
    print("focusNode2.hasFocus = ${focusNodetwo.hasFocus}");
    setState(() {
      if (focusNodetwo.hasFocus) {
        print("focused");
      } else {
        print("not focused");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    FocusScope.of(context).requestFocus(focusNodetwo);

    return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      DecoratedBox(
                        child: Text('first Box'),
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                      DecoratedBox(
                        child: Text('second Box'),
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                      RawKeyboardListener(
                        child: DecoratedBox(
                          child: Text('third Box'),
                          decoration: BoxDecoration(
                              color: focusNodetwo.hasFocus
                                  ? Colors.grey
                                  : Colors.transparent),
                        ),
                        focusNode: focusNodetwo,
                        onKey: (RawKeyEvent event) {
                          if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid){
                            print('keydown');
                            RawKeyDownEvent ev = event;
                            RawKeyEventDataAndroid evAndroid = ev.data;
                            print(evAndroid.keyCode);
                            
                          }
                        },
                      ),
                    ]));
  }
}