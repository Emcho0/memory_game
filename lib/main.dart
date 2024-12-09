import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_game/widgets/score_board.dart';
import 'package:memory_game/utils/game_logic.dart';
import 'package:just_audio/just_audio.dart';

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
  late AudioPlayer _audioPlayer; // For background music
  late AudioPlayer _tapPlayer; // For tap sound
  final Game _game = Game();
  // inicijalizacija podataka za pokušaje i score na 0
  int moves = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    // Inicijalizacija audioplayera za muziku
    _audioPlayer = AudioPlayer();
    _tapPlayer = AudioPlayer();

    _playMusic();
    _game.initGame();
  }

  // funkcija koja pusta muziku i vraca gresku ako ima
  void _playMusic() async {
    try {
      await _audioPlayer.setAsset('assets/music/background.mp3');

      await _audioPlayer.setLoopMode(LoopMode.one);

      await _audioPlayer.play();
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  void _playTapSound() async {
    try {
      await _tapPlayer.setAsset('assets/music/tap.mp3');
      await _tapPlayer.play();
    } catch (e) {
      print("Error playing tap sound: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _tapPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nasa igra mora biti velicine screen_w*screen_w
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
              // Widget for showing the game score
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
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _playTapSound();

                    if (_game.gameImg![index] != _game.hiddenCardpath) {
                      return;
                    }

                    setState(() {
                      moves++;
                      _game.gameImg![index] = _game.cardsList[index];
                      _game.matchCheck.add({index: _game.cardsList[index]});
                    });

                    if (_game.matchCheck.length == 2) {
                      if (_game.matchCheck[0].values.first ==
                          _game.matchCheck[1].values.first) {
                        setState(() {
                          score += 100;
                          _game.matchCheck.clear();
                        });
                      } else {
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
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 179, 135),
                      borderRadius: BorderRadius.circular(8.0),
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
