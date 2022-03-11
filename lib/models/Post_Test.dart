import 'dart:ffi';

class Post {
  final String title;
  final String urlImg;
  final String urlVideo;
  final String description;
  final String author;
  final int likes;

  Post(this.likes, this.title, this.author, this.description, this.urlImg,
      this.urlVideo);

  static List<Post> getList() {
    return [
      Post(
        4900,
        "Le meilleur vin au monde",
        "Cavawine",
        "Je vous promet c'est le meilleur vin du monde",
        "https://images.vivino.com/thumbs/T6RIqhmIQ-Cy2wcFSaDGeg_pb_x600.png",
        "nope",
      ),
      Post(
        490,
        "Paysage sympa",
        "Unknow",
        "C'est bo",
        "https://static.fnac-static.com/multimedia/Images/FD/Comete/114332/CCP_IMG_ORIGINAL/1481839.jpg",
        "nope",
      ),
      Post(
        590,
        "Le pire vin au monde",
        "Vivino",
        "Je vous promet c'est tro tro mauvais",
        "https://images.vivino.com/thumbs/T6RIqhmIQ-Cy2wcFSaDGeg_pb_x600.png",
        "nope",
      )
    ];
  }
}
