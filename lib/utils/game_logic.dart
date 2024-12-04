
class Game {
  final String hiddenCardpath ='assets/images/hidden.png';
   List <String>? gameImg;

   final List <String> cards_list = [
  "assets/image/circle.p",
  "assets/image/triangle.p",
  "assets/image/circle.p",
  "assets/image/heart.p",
  "assets/image/star.p",
  "assets/image/triangle.p",
  "assets/image/star.p",
  "assets/image/heart.p",
   ];
   
   List<Map<int, String>> matchCheck = [];




  final int cardCount = 8;

  void initGame(){
gameImg = List.generate(cardCount, (index)=> hiddenCardPath);


  }
}