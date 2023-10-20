import 'package:flutter/material.dart';

void main() {
  runApp(const DoorAnimationApp());
}

class DoorAnimationApp extends StatelessWidget {
  const DoorAnimationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoorAnimationScreen(),
    );
  }
}

class DoorAnimationScreen extends StatefulWidget {
  const DoorAnimationScreen({Key? key}) : super(key: key);

  @override
  _DoorAnimationScreenState createState() => _DoorAnimationScreenState();
}

class _DoorAnimationScreenState extends State<DoorAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    anim();
    super.initState();
  }

  anim() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.addListener(() {
      // This callback will be invoked whenever the animation value changes
      setState(() {
        // Update your UI or perform actions based on the animation value
      });
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                width: _animationController.isCompleted ? 200 : 100,
                height: _animationController.isCompleted ? 200 : 100,
                child: Image.asset("flutter.png"),
              ),
            ),
            Positioned(
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final angle = _animationController.value * 4;

                    return Row(
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(-angle / 2.5),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle / 2.5),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
