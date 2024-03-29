import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress;
  final Color color;

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() =>
      _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = Tween<double>(begin: 0, end: widget.progress)
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          // used when no transition widget cna work
          animation: animation,

          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: animation.value,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade100,
                    color: widget.color,
                  ),
                ),
                Text(
                  // dont remove the * 100 as the ideal
                  // range of animation.value will always be
                  // between 0 & 1 as they represent the entirety
                  // of the circular progress indicator,
                  // in simple words, a value of > 1 in circularProgress
                  // means perimeter exceeded
                  '${(animation.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.forward();
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
