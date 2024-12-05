import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_game/widgets/score_board.dart';
import 'package:memory_game/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

// Widget početne strane naše memory igre
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Game _game = Game();
  // inicijalizacija podataka za pokušaje i score na 0
  int moves = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    // nasa igraona ploca mora biti jednaka screen_w*screen_w
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 27),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Memory Game",
              style: GoogleFonts.tsukimiRounded(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 205, 214, 244),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Widget funckija za skor igre
              scoreBoard("Moves", moves.toString()),
              scoreBoard("Score", score.toString()),
            ],
          ),
          SizedBox(
            height: screenWidth,
            width: screenWidth,
            child: GridView.builder(
              itemCount: _game.gameImg?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (_game.gameImg![index] != _game.hiddenCardpath) {
                      // Ignorisati dodori ako je otkrivena karta već pritisnuta
                      return;
                    }

                    setState(() {
                      moves++;
                      _game.gameImg![index] = _game.cardsList[index];
                      _game.matchCheck.add({index: _game.cardsList[index]});
                    });

                    if (_game.matchCheck.length == 2) {
                      // Provjera ako su dvije susjedne karte iste
                      if (_game.matchCheck[0].values.first ==
                          _game.matchCheck[1].values.first) {
                        setState(() {
                          // Povecanje score za 100
                          score += 100;
                          _game.matchCheck.clear();
                        });
                      } else {
                        // Funckija koja daje korisniku 800ms vremena da vidi koja je druga karta ako nije pogodio
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            _game.gameImg![_game.matchCheck[0].keys.first] =
                                _game.hiddenCardpath;
                            _game.gameImg![_game.matchCheck[1].keys.first] =
                                _game.hiddenCardpath;
                            _game.matchCheck.clear();
                          });
                        });
                      }
                    }
                  },
                  child: Container(
                    // izgled jedne kocke
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 179, 135),
                      borderRadius: BorderRadius.circular(8.0),
                      // unutar kontejnera ubacujemo sliku naših gemoetrijskih likova
                      image: DecorationImage(
                        image: AssetImage(_game.gameImg![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

