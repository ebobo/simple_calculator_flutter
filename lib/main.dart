import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_cal_flutter/screens/connection_status.dart';
import 'package:simple_cal_flutter/screens/results.dart';
import 'package:simple_cal_flutter/service/rest.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K8s Simple Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'K8s Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPlusMicroserviceUp = false;
  bool _isMinusMicroserviceUp = false;
  bool _isMultiplyMicroserviceUp = false;
  bool _isDivideMicroserviceUp = false;
  double _plusResult = 0;
  double _minusResult = 0;
  double _multiplyResult = 0;
  double _divideResult = 0;
  final _firstNumberController = TextEditingController();
  final _secondNumberController = TextEditingController();
  final _apiService = ApiService();

  void _handleSubmit() async {
    final firstNumber = double.parse(_firstNumberController.text);
    final secondNumber = double.parse(_secondNumberController.text);

    print('firstNumber: $firstNumber secondNumber: $secondNumber');
    final plusResult = await _apiService.plus(firstNumber, secondNumber);

    print('plusResult: $plusResult');
    setState(() {
      _plusResult = plusResult;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer t) {
      _checkBackendHealth();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  // check backend health
  Future<void> _checkBackendHealth() async {
    // check plus microservice health
    final plusMicroserviceUp = await _apiService.checkPlusServiceHealth();
    setState(() {
      _isPlusMicroserviceUp = plusMicroserviceUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            ConnectionStatusRow(
                plusMicroserviceUp: _isPlusMicroserviceUp,
                minusMicroserviceUp: _isMinusMicroserviceUp,
                multiplyMicroserviceUp: _isMultiplyMicroserviceUp,
                divideMicroserviceUp: _isDivideMicroserviceUp),
            const SizedBox(height: 80),
            ResultsRow(
                plusResult: _plusResult,
                minusResult: _minusResult,
                multiplyResult: _multiplyResult,
                divideResult: _divideResult),
            const SizedBox(height: 80),
            const Text(
              'Input two numbers:',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '1st Number',
                      ),
                      validator: (value) {
                        if (value != null && value.trim().isEmpty) {
                          return 'Number A is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _secondNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '2nd Number',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmit,
        tooltip: 'Increment',
        child: const Icon(Icons.drag_handle),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
