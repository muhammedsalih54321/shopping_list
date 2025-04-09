import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  bool isNewPage = false;

  void navigateToNewPage() {
    setState(() {
      isNewPage = true;
    });
  }

  void goBackToHome() {
    setState(() {
      isNewPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar Example'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.settings), text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            isNewPage ? NewPage(onBack: goBackToHome) : HomeScreen(onNavigate: navigateToNewPage),
            SettingsScreen(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  HomeScreen({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Screen", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNavigate,
            child: Text("Go to New Page"),
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final VoidCallback onBack;
  NewPage({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.yellow,
          leading: IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("New Page"),
        ),
        Expanded(
          child: Center(
            child: Text("New Page Content", style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Screen", style: TextStyle(fontSize: 20)),
    );
  }
}
