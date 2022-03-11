import 'package:redditech/utils/Api.dart' as Api;

class Post {
  String title;
  String fullname;
  String? urlImg;
  String? urlVideo;
  String? description;
  String author;
  int likes;
  Post({
    required this.likes,
    required this.title,
    required this.fullname,
    required this.author,
    this.description,
    this.urlImg,
    this.urlVideo,
  });

  static Future<Post> fetchPost() async {
    var json = await Api.useApi(method: "GET", json: false, url: "api/v1/post");
    var like = json['like'] as int;
    var title = json['title'] as String;
    var fullname = json['fullname'] as String;
    var author = json['author'] as String;
    var description = json['description'] as String;
    var urlImg = json['image'] as String;
    var urlVideo = json['urlVideo'] as String;
    return Post(
      likes: like,
      title: title,
      fullname: fullname,
      author: author,
      description: description,
      urlImg: urlImg,
      urlVideo: urlVideo,
    );
  }
}
