import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(26.0),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 69, 71, 90),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 22.0,
                color: Color.fromARGB(
                    255, 116, 199, 236) // Set a contrasting color here
                ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            info,
            style: GoogleFonts.varelaRound(
                fontSize: 34.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
