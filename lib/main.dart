import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyController extends GetxController {
  List<String> list = [];

  void add() {
    list.add(' ');
    update();
  }

  void sub() {
    if (list.isNotEmpty) {
      list.removeLast();
      update();
    }
  }
}

class Badge extends StatelessWidget {
  final Function addClick;
  final Function subClick;

  const Badge({
    Key? key,
    required this.addClick,
    required this.subClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    return Container(
      color: Colors.grey,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: myController.add,
                icon: const Icon(Icons.add_circle),
              ),
              IconButton(
                onPressed: myController.sub,
                icon: const Icon(Icons.remove_circle),
              ),
            ],
          ),
          if (myController.list.isNotEmpty)
            Positioned(
              top: 0,
              right: 3,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  Get.find<MyController>().list.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final MyController myController = Get.put(MyController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Badge'),
        ),
        body: Center(
          child: GetBuilder<MyController>(
            builder: (controller) {
              return Badge(
                addClick: () {
                  myController.add();
                },
                subClick: () {
                  myController.sub();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
