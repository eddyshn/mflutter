// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provide the model to all widgets within the app. We're using
    // ChangeNotifierProvider because that's a simple way to rebuild
    // widgets when a model changes. We could also just use
    // Provider, but then we would have to listen to Counter ourselves.
    //
    // Read Provider's docs to learn about all the available providers.
    ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own Counter's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Counter with ChangeNotifier {
  int value1 = 0;
  int value2 = 0;

  void increment1() {
    value1 += 1;
    notifyListeners();
  }

  void increment2() {
    value2 += 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          //使用Consumer来获取CounterProvider，为Text提供数据
          Selector<Counter, int>(
            builder: (BuildContext context, int value1, Widget child) {
              print('Text1重绘了。。。。。。');
              var rng = new Random();
              var r = rng.nextInt(100);
              return Text(
                //获取数据
                'Text1重绘了$r-> : $value1',
                style: TextStyle(fontSize: 20),
              );
            },
            selector: (context, counter) => counter.value1,
          ),
          Selector<Counter, int>(
            builder: (BuildContext context, int value2, Widget child) {
              print('Text2重绘了。。。。。。');
              var rng = new Random();
              var r = rng.nextInt(100);
              return Text(
                //获取数据
                'Text2重绘了$r-> : $value2',
                style: TextStyle(fontSize: 20),
              );
            },
            selector: (context, counter) => counter.value2,
          ),
          ElevatedButton(
            onPressed: () {
              print('Button 1被点击了。。。。。。。。。。');
              var counter = context.read<Counter>();
              counter.increment1();
            },
            child: Text('Button1'),
          ),
          ElevatedButton(
            onPressed: () {
              print('Button 2被点击了。。。。。。。。。。');
              var counter = context.read<Counter>();
              counter.increment2();
            },
            child: Text('Button2'),
          ),
          Consumer(
              builder: (BuildContext context, Counter counter, Widget child) {
                print('Text1重绘了。。。。。。');
                var rng = new Random();
                var r = rng.nextInt(100);
                return Text(
                  //获取数据
                  'Text1重绘了$r-> : ${counter.value1}',
                  style: TextStyle(fontSize: 20),
                );
              }),
          Consumer(builder: (BuildContext context,
              Counter counter, Widget child) {
            print('Text2重绘了。。。。。。');
            var rng = new Random();
            var r = rng.nextInt(100);
            return Text(
              //获取数据
              'Text2重绘了$r-> : ${counter.value2}',
              style: TextStyle(fontSize: 20),
            );
          }),
          ElevatedButton(
            onPressed: () {
              print('Button 1被点击了。。。。。。。。。。');
              var counter = context.read<Counter>();
              counter.increment1();
            },
            child: Text('Button1'),
          ),
          ElevatedButton(
            onPressed: () {
              print('Button 2被点击了。。。。。。。。。。');
              var counter = context.read<Counter>();
              counter.increment2();
            },
            child: Text('Button2'),
          ),
        ],
      )),
    );
  }
}
