import 'package:snake/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/snake_game.png'),
          const SizedBox(height: 50.0),
          const Text('Welcome to SnakeGameFlutter',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 50.0),
          FilledButton.icon(
             onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const GamePage()));
              },
              icon: const Icon(Icons.play_circle_filled,
                  color: Colors.white, size: 30.0),
              label: const Text("Start the Game...",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ],
      ),
    ));
  }
}
