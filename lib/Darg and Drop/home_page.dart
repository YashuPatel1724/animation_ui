import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Matching Game'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Draggable animal images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: animals.keys.map((animalImageUrl) {
              return Draggable<String>(
                data: animalImageUrl,
                feedback: Image.network(fit: BoxFit.cover,animalImageUrl, width: 100),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: Image.network(fit: BoxFit.cover,animalImageUrl, width: 100),
                ),
                child: matched[animalImageUrl] == true
                    ? Container(width: 80) // Empty if matched
                    : Image.network(fit: BoxFit.cover,animalImageUrl, width: 100),
              );
            }).toList(),
          ),
          // DragTarget areas (animal names)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: animals.entries.map((entry) {
              String animalImageUrl = entry.key;
              String animalName = entry.value;
              return DragTarget<String>(
                onAccept: (data) {
                  if (data == animalImageUrl) {
                    setState(() {
                      matched[animalImageUrl] = true;
                    });
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: matched[animalImageUrl] == true
                          ? Colors.green
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      animalName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // Reset button
          ElevatedButton(
            onPressed: () {
              setState(() {
                matched.clear();
              });
            },
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
final Map<String, String> animals = {
  '\https://cdn.britannica.com/36/234736-050-4AC5B6D5/Scottish-fold-cat.jpg': 'Cat',
  'https://cdn.britannica.com/29/150929-050-547070A1/lion-Kenya-Masai-Mara-National-Reserve.jpg': 'Lion',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCJZ41OQhg9LCI5O2DA1aAifGP5BrnECseAR03snR0Mo7vlHEyRYL2xv0XqyP7ch3MrjU&usqp=CAU': 'Dog',
};

final Map<String, bool> matched = {};
