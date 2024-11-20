import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GreetingAnimationPage extends StatefulWidget {
  const GreetingAnimationPage({Key? key}) : super(key: key);

  @override
  State<GreetingAnimationPage> createState() => _GreetingAnimationPageState();
}

class _GreetingAnimationPageState extends State<GreetingAnimationPage> {
  String name = "";
  bool showGreeting = false;
  bool showMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Widgets"),
      ),
      body: Stack(
        children: [
          // Name Animation
          AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            alignment: showGreeting ? Alignment.topLeft : Alignment.center,
            child: showGreeting
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedTextKit(
                totalRepeatCount: 1, // Ensure it animates only once
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Hi, $name",
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                onFinished: () {
                  // Show message box after the animation finishes
                  setState(() {
                    showMessage = true;
                  });
                },
              ),
            )
                : const SizedBox.shrink(),
          ),
          // TextField Centered
          Center(
            child: showGreeting
                ? const SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                    showGreeting = true;
                  });
                },
              ),
            ),
          ),
          // Message Box
          AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: showMessage ? MediaQuery.of(context).size.width * 0.8 : 0,
              height: showMessage ? 100 : 0,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: showMessage
                  ? const Center(
                child: Text(
                  "Only I can change my life. No one can do it for me.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
