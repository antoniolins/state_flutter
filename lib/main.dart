import 'package:flutter/material.dart';
import 'package:state_flutter/bloc/counter_bloc.dart';
import 'package:state_flutter/bloc/counter_event.dart';
import 'package:state_flutter/bloc/counter_state.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_flutter/bloc_visibility/visibility_bloc.dart';
import 'package:state_flutter/bloc_visibility/visibility_event.dart';
import 'package:state_flutter/bloc_visibility/visibility_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(

        providers: [
          BlocProvider(create: (context)=>CounterBloc()),
          BlocProvider(create: (context)=>VisibilityBloc()),
        ],
      
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  // final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              // bloc: counterBloc,
              builder: (context, state) {
                return Text(
                  state.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            BlocBuilder<VisibilityBloc, VisibilityState>(
              builder: (context, state) {
                return Visibility(
                    visible: state.show,
                    child: Container(
                      color: Colors.purple,
                      width: 200,
                      height: 200,
                    ));
              },
            ),
            BlocListener<CounterBloc,CounterState>(

              listenWhen: (prevState, currentState)=>true,
              listener: (context,state){
                
              if (state.count == 3) {
                ScaffoldMessenger.of(context).
                       showSnackBar(SnackBar(content: Text('Counter value is ${state.count}')));
              }
            },
            child: const Text('Bloc Listener'),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              // counterBloc.add(CounterIncrementEvent());
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              //             counterBloc.add(CounterDecrementEvent());
              context.read<CounterBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
          FloatingActionButton(
            onPressed: () {
                context.read<VisibilityBloc>().add(VisibilityShowEvent());
            },
            child: const Text('Show'),
          ),
          FloatingActionButton(
            onPressed: () {
                context.read<VisibilityBloc>().add(VisibilityHideEvent());
            },
            child: const Text('Hide'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
