import 'package:bloc_concepts/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented) {
            // do increment SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Increment'),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              SizedBox(height: 20),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  var message = '';
                  if (state.counterValue == 0) {
                    message = 'Zero ';
                  } else if (state.counterValue == 5) {
                    message = 'Ahhhh ';
                  } else if (state.counterValue < 0) {
                    message = 'Minus ';
                  }

                  return Text(
                    message + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
