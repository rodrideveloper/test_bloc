import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/home/home_bloc/home_bloc.dart';
import 'package:test_bloc/home/home_page.dart';
import 'package:test_bloc/services.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => HomeBloc(itemService: ItemService()),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}
