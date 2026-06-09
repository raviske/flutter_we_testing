import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiFetching extends StatefulWidget {
  const ApiFetching({super.key});

  @override
  State<ApiFetching> createState() => _ApiFetchingState();
}

class _ApiFetchingState extends State<ApiFetching> {
  List<dynamic> data = [];
  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Fetching')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['title']),
            subtitle: Text(data[index]['body']),
            leading: Icon(Icons.article),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
