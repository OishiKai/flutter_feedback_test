import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    BetterFeedback(
      theme: FeedbackThemeData(
        // フィードバックモードの背景色
        background: Colors.grey,
        // フィードバックのシート色
        feedbackSheetColor: Colors.white,
        // ペンの色
        drawColors: [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.orange,
        ],
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Feedback Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.feedback),
              onPressed: () {
                BetterFeedback.of(context).show((UserFeedback feedback) {
                  // フィードバックのテキスト
                  print(feedback.text);
                  // フィードバックのスクリーンショット
                  print(feedback.screenshot);

                  /*
                  ここでFirebaseなどにフィードバックを送信する処理を書く
                   */

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('フィードバックを送信しました。ご報告ありがとうございます！'),
                    ),
                  );
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
