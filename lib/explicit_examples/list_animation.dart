import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  // late Animation<Offset> slideAnimation; using this wont work for varied lists
  late List<Animation<Offset>> slideEachListTileAnimation;
  final int itemCount = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    slideEachListTileAnimation = List.generate(
        itemCount,
        (index) => Tween(begin: Offset(-1, 0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval(index * (1 / itemCount), 1))));

    // index is initially = 0, hence 1/itemCount = 0.2 seconds
    // using 0.2s or 1/itemCount directly is static
    // multiplying with the index is what makes the animation dynamic
    //   as the index will keep changing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: slideEachListTileAnimation[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
