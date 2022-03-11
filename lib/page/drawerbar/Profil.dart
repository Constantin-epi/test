import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditech/models/User.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: buildAppBar(context: context, back: true),     WIDGET
//         body: FutureBuilder<User>(                   LOADER
//             future: User.fetchUser(),                FONCTION CALL AU LANCEMENT --> DATA
//             builder: (context, snapshot) {           FRONT
//               if (snapshot.hasData) {            SI LA DATA EST LOAD
//                 var user = snapshot.data!;
//                 return ListView(
//                   physics: BouncingScrollPhysics(),      return mon front
//                   children: buildContent(user),
//                 );
//               } else {                           SI LA DATA EST PAS LOAD
//                 return Center(child: CircularProgressIndicator());
//               }
//             }));
//   }
class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffff4300),
      ),
      body: FutureBuilder<User>(
          future: User.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data!;
              return Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.network(user.banner ??
                        "https://wpimg.pixelied.com/blog/wp-content/uploads/2021/08/03132815/relevant-elements-reddit-banner-size.jpg"),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: 500,
                      child: Card(
                        child: Column(children: <Widget>[
                          Container(
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xffFDCF09),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(user.img!),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              user.name!,
                              style: TextStyle(
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                // width: 90,
                                // height: 50,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: Text("Karma: " + user.karma.toString()),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                // width: 90,
                                // height: 50,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: Text("Coins: " + user.coins.toString()),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(user.creation.toString()),
                      ),
                    )),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
// body: FutureBuilder<User>(
//     future: User.fetchUser(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         var user = snapshot.data!;
//         return ListView(
//           physics: BouncingScrollPhysics(),
//           children: buildContent(user),
//         );
//       } else {
//         return Center(child: CircularProgressIndicator());
//       }
//     })
