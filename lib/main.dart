import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text("Rest API Call")),
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user['name']['first'];
            final email = user['email'];
            final imageUrl = user['picture']['thumbnail'];
            // final city = user['location']['city'];
            return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(imageUrl),
                ),
                title: Text(name),
                subtitle: Column(
                  children: [
                    Text(email),
                    // Text(city),
                  ],
                ));
          }),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: fetchUsers,
      ),

    );
  }

  void fetchUsers() async {
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
    print("fetchUser called");
  }

}
