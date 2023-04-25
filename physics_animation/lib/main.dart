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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

//HomePage
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Animation'),
      ),
      body: const DragabbleCard(
        child: FlutterLogo(
          size: 150,
        ),
      ),
    );
  }
}

//
class DragabbleCard extends StatefulWidget {
  const DragabbleCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<DragabbleCard> createState() => _DragabbleCardState();
}

class _DragabbleCardState extends State<DragabbleCard>
    with SingleTickerProviderStateMixin {
  //Criando um animation controller para inserir no init state e poder controlar o estado da animação
  late AnimationController _controller;
  //Iniciando o alinhamento da imagem no centro
  Alignment _dragAlignment = Alignment.center;

  //iniciando o estado da pagina
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  //garbage colector
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {},
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            //fisica da movimentação
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {},
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
