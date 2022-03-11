import 'package:flutter/material.dart';
import 'package:redditech/models/Post_Test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:redditech/models/Subreddit.dart';
import 'package:redditech/utils/Api.dart' as Api;

class Default extends StatefulWidget {
  @override
  _DefaultState createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  late List<Post> post;
  static const _size = 20;
  String after = "";
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  @override
  initState() {
    pagingController.addPageRequestListener((pageKey) {
      buildPost(pageKey);
    });
    post = Post.getList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(
              () => pagingController.refresh(),
            ),
        child: PagedListView<int, dynamic>(
          shrinkWrap: true,
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
            itemBuilder: (context, item, index) => PrintPost(item),
          ),
        ));
  }

  Future<void> buildPost(int pageKey) async {
    try {
      final data = await Api.useApi(
          method: "GET",
          json: false,
          url: 'api/subreddits/default&count=$pageKey&after=$after');
      final len = data['data']['dist'] as int;
      after = data['data']['after'] != null ? data['data']['after'] : '';
      final newItems = getone(data);
      final isLastPage = len < _size;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + len;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      pagingController.error = error;
    }
  }

  List<dynamic> getone(Map<String, dynamic> data) {
    List<Subreddit> post = [];
    data['data']['children'].forEach((item) {
      try {
        if (item['kind'] == 't5') {
          post.add(Subreddit(
              title: (item['data']['title'] != null
                  ? item['data']['title'] as String
                  : ''),
              avatar: (item['data']['community_icon'] == null
                  ? ''
                  : (item['data']['community_icon'] as String)
                      .replaceFirst('?', '#')),
              subscribers: (item['data']['subscribers'] != null
                  ? item['data']['subscribers'] as int
                  : 0),
              displayname: (item['data']['display_name'] != null
                  ? (item['data']['display_name'] as String)
                  : ''),
              name: (item['data']['name'] != null
                  ? item['data']['name'] as String
                  : ''),
              description: (item['data']['description'] != null
                  ? item['data']['description'] as String
                  : ''),
              banner_background_image:
                  ((item['data']['banner_background_image'] == null)
                      ? ''
                      : (item['data']['banner_background_image'] as String)
                          .replaceFirst('?', '#')),
              isSubscribed: item['data']['user_is_subscriber'] == null
                  ? false
                  : item['data']['user_is_subscriber'],
              fullname: item['data']['name']));
        }
      } catch (e) {
        print(e);
      }
    });
    return (post);
  }

  void subscribe(Function callBack) {
    setState(() {
      callBack();
    });
  }

  Widget PrintPost(Subreddit sub) {
    const String tmpUrl =
        "https://play-lh.googleusercontent.com/8Vw-7MAm558750a4M55fiOlUf7lP2cYnFuqSWynrygIiyEEiQQDa_xxHKYOX83L0UD2T";
    return Column(children: [
      ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(sub.avatar.isEmpty ? tmpUrl : sub.avatar),
          ),
          title: Text(sub.title),
          subtitle: Text('Subscribers : ${sub.subscribers}\n'),
          isThreeLine: true,
          trailing: IconButton(
            icon: Icon(sub.isSubscribed ? Icons.remove : Icons.add),
            onPressed: () => this.subscribe(() => sub.subscribe()),
          )),
      SizedBox(
          height: sub.banner_background_image.isEmpty ? 0 : 100,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(sub.banner_background_image.isEmpty
                    ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png'
                    : sub.banner_background_image),
              ),
            ),
          )),
      Divider()
    ]);
  }
}
