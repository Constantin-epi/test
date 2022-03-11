import 'package:redditech/utils/Api.dart' as Api;

class User {
  String? img;
  String? name;
  String? real;
  String? banner;
  int? karma;
  int? coins;
  int? creation;
  Map<String, dynamic>? trophies;

  User({
    this.img,
    this.name,
    this.real,
    this.banner,
    this.karma,
    this.coins,
    this.creation,
    this.trophies
  });
  static Future<User> fetchUser() async {
    var json = await Api.useApi(method: "GET", json: false, url: "api/v1/me");
    var img = (json['icon_img'] as String).split('?')[0];
    var banner = (json['subreddit']['banner_img'] as String).split('?')[0];
    var name = json['name'] as String;
    var real = json['subreddit']['display_name_prefixed'] as String;
    var karma = json['total_karma'] as int;
    var coins = json['coins'] as int;
    var creation = (json['created'] as double).round();
     json =
       await Api.useApi(method: "GET", json: false, url: "api/v1/me/trophies");
     var trophies = json['data'] as Map<String, dynamic>;
    return User(
      img: img,
      name: name,
      real: real,
      banner: banner,
      karma: karma,
      coins: coins,
      creation: creation,
      trophies: trophies
    );
  }
}
