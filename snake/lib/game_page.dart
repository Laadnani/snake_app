import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/game_over.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late int _playerScore;
  late bool _hasStarted;
  late Animation<double> _snakeAnimation;
  late AnimationController _snakeController;
  final List _snake = [404, 405, 406, 407];
  final int _noOfSquares = 500;
  final Duration _duration = const Duration(milliseconds: 250);
  final int _squareSize = 20;
  late String _currentSnakeDirection;
  late int _snakeFoodPosition;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while (_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);
  }

  void _gameStart() {
    Timer.periodic(const Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();
      if (_hasStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++) {
      if (_snake.last == _snake[i]) return true;
    }
    return false;
  }

  void _updateSnake() {
    if (!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 4) * 100;
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares) {
              _snake.add(
                  _snake.last + _squareSize - (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last + _squareSize);
            }
            break;
          case 'UP':
            if (_snake.last < _squareSize) {
              _snake.add(
                  _snake.last - _squareSize + (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last - _squareSize);
            }
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0) {
              _snake.add(_snake.last + 1 - _squareSize);
            } else {
              _snake.add(_snake.last + 1);
            }
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0) {
              _snake.add(_snake.last - 1 + _squareSize);
            } else {
              _snake.add(_snake.last - 1);
            }
        }

        if (_snake.last != _snakeFoodPosition) {
          _snake.removeAt(0);
        } else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GameOver(score: _playerScore)));
        }
      });
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('SnakeGameFlutter',
          style: TextStyle(color: Colors.white, fontSize: 16.0)),
      centerTitle: false,
      backgroundColor: const Color.fromARGB(255, 71, 60, 60),
      actions: <Widget>[
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('Score: $_playerScore',
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        ))
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 107, 92, 92),
        elevation: 20,
        label: Text(
          _hasStarted ? 'Start' : 'Pause',
          style: const TextStyle(),
        ),
        onPressed: () {
          setState(() {
            if (_hasStarted) {
              _snakeController.forward();
            } else {
              _snakeController.reverse();
            }
            _hasStarted = !_hasStarted;
            _gameStart();
          });
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _snakeAnimation,
        )),
    body: 
    
    Container( 
      color:  const Color.fromARGB(255, 17, 17, 17),
      child: Column(
      
      children: [
        Expanded(
          child: GestureDetector(
            onVerticalDragUpdate: (drag) {
              if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP') {
                _currentSnakeDirection = 'DOWN';
              } else if (drag.delta.dy < 0 &&
                  _currentSnakeDirection != 'DOWN')
                // ignore: curly_braces_in_flow_control_structures
                _currentSnakeDirection = 'UP';
            },
            onHorizontalDragUpdate: (drag) {
              if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT') {
                _currentSnakeDirection = 'RIGHT';
              } else if (drag.delta.dx < 0 &&
                  _currentSnakeDirection != 'RIGHT')
                // ignore: curly_braces_in_flow_control_structures
                _currentSnakeDirection = 'LEFT';
            },
            // ignore: sized_box_for_whitespace
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: _squareSize + _noOfSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _squareSize,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        index == _snakeFoodPosition || index == _snake.last
                            ? 7
                            : 2.5,
                      ),
                      child: Container(
                        color: _snake.contains(index)
                            ? const Color.fromARGB(255, 189, 188, 188)
                            : index == _snakeFoodPosition
                                ? Colors.green
                                : Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

      ],
    ),
    ),
  );
} 
}
