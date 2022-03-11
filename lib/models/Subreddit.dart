import 'package:redditech/utils/Api.dart';

class Subreddit {
  String title;
  String avatar;
  int subscribers;
  String displayname;
  String name;
  String description;
  String banner_background_image;
  String fullname;
  bool isSubscribed;
  Subreddit(
      {required this.title,
      required this.avatar,
      required this.subscribers,
      required this.displayname,
      required this.name,
      required this.description,
      required this.banner_background_image,
      required this.isSubscribed,
      required this.fullname});

  void subscribe() async {
    if (isSubscribed) {
      isSubscribed = false;
      await useApi(
          method: 'POST',
          json: false,
          url: 'api/subscibe',
          data: {'action': 'unsub', 'sr': '${this.name},'},
          type: 'application/x-www-form-urlencoded');
    } else {
      isSubscribed = true;
      print(await useApi(
          method: 'POST',
          json: false,
          url: 'api/subscribe',
          data: {'action': 'sub', 'sr': '${this.name},'},
          type: 'application/x-www-form-urlencoded'));
    }
  }
}
