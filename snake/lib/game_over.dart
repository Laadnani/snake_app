import 'package:snake/game_page.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final int score;

  const GameOver({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 3, 3, 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         const Text('Game Over',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                        // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: Colors.black),
                    Shadow(
                        // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: Colors.black),
                    Shadow(
                        // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.black),
                    Shadow(
                        // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: Colors.black),
                  ])),
          const SizedBox(height: 50.0),
          Text('Your Score is: $score',
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20.0)),
          const SizedBox(height: 50.0),
 ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              iconColor: Colors.redAccent, // Background color
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            },
            icon: const Icon(Icons.refresh, color: Color.fromARGB(255, 2, 2, 2), size: 30.0),
            label: const Text(
              "Try Again",
              style: TextStyle(color: Color.fromARGB(255, 14, 13, 13), fontSize: 20.0),
            ),
          ),

        ],
      ),
    ));
  }
}
