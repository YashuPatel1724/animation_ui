import 'package:flutter/material.dart';

class PlaneAnimationPage extends StatefulWidget {
  const PlaneAnimationPage({Key? key}) : super(key: key);

  @override
  State<PlaneAnimationPage> createState() => _PlaneAnimationPageState();
}

class _PlaneAnimationPageState extends State<PlaneAnimationPage> {
  bool _isPlaneUp = false;
  int index = 0;

  final List<Alignment> align = [
    Alignment.bottomLeft,
    Alignment.topCenter,
    Alignment.bottomRight,
  ];

  void _toggleAnimation() {
    setState(() {
      _isPlaneUp = !_isPlaneUp;

      // Ensure the index wraps within the range of the list
      if (index == align.length - 1) {
        index = 0;
      } else {
        index++;
      }
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      color: _isPlaneUp ? Colors.blue[100] : Colors.white,
      child: Stack(
        children: [
          // Animated Plane Position
          AnimatedAlign(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            alignment: _isPlaneUp ? Alignment.topCenter : align[index],
            child: Icon(
              Icons.flight,
              size: 48,
              color: Colors.teal,
            ),
          ),
          // Button to Toggle Animation
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: ElevatedButton(
              onPressed: _toggleAnimation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text("Toggle Animation",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
