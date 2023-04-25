import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation in Page Route',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation in Page Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Navigate'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SecondPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //Criado um tween para converter em animação
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      //Defininto o tempo de criação da animação utilizando o widget Curves
      var curve = Curves.ease;
      var curveTween = CurveTween(curve: curve);
      //Combinando os dois tweens criados
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offSetAnimation = animation.drive(tween);

      //Faz a pagina ter uma transição em slide de baixo pra cima
      return SlideTransition(
        position: offSetAnimation,
        child: child,
      );
    },
  );
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation in Page Route'),
      ),
      body: const Center(
        child: Text(
          'Second Page!',
        ),
      ),
    );
  }
}
