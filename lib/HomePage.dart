import 'package:flutter/material.dart';
import 'package:redditech/page/nav/New.dart';
import 'package:redditech/page/nav/Gold.dart';
import 'package:redditech/page/nav/Default.dart';
import 'package:redditech/LoginScreen.dart';
import 'package:redditech/page/drawerbar/Settings.dart';
import 'package:redditech/page/drawerbar/Profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Redditech");

  static List<Widget> _widgetOptions = <Widget>[
    Default(),
    Gold(),
    New(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffff4300),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text("Reditech");
                  }
                });
              },
              icon: cusIcon),
          IconButton(
            onPressed: () => Navigator.of(context),
            icon: Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/DrawBar.png'),
                ),
              ),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('profil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profil()),
                    );
                  }),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Disconnect'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffff4300),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_sharp),
            label: 'Tendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            label: 'News',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
