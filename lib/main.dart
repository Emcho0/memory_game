import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_game/widgets/score_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// dodavanje elemenata igre

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Game _game = Game ();
  @override
  void initState(){
    super.initState();
    _game.initGame();

  }
  Widget build(BuildContext context) {
    // nasa igraona ploca mora biti jednaka screen_w*screen_w
    double screen_w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 27),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Memory game",
              style: GoogleFonts.montserrat(
                fontSize: 50,
                color: const Color.fromARGB(255, 205, 214, 244),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // widget funckija za skor igre
              scoreBoard("Tries", "0"),
              scoreBoard("Score", "0"),
            ],
          ),
          SizedBox(
            height: screen_w,
            width: screen_w,

            child: GridView.builder(
              itemCount: _game.gameImg!.length
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(

                  )
                    onTap(){

                    }

                    
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration ,
                      color: Color(0xFFFFB46A),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage (
                      image: AssetImage(_game.gameImg![index]),
                      fit: BoxFit.cover,

                      )

                    )
   } ),
          )
        ],
      ),
    );
  }
}
