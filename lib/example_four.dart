import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;

  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api tut 4'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else {
                  // return Text(data[0]['name']
                  //     .toString()); // 0 for initial index of array and name for 'name' key in that index, see users request in postman
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              ReusableRow(
                                  title: 'name',
                                  value: data[index]['name'].toString()),
                              ReusableRow(
                                  title: 'username',
                                  value: data[index]['username'].toString()),
                              ReusableRow(
                                  title: 'address',
                                  value: data[index]['address']['street']
                                      .toString()),
                              ReusableRow(
                                  title: 'lat',
                                  value: data[index]['address']['geo']['lat']
                                      .toString()),
                              ReusableRow(
                                  title: 'lng',
                                  value: data[index]['address']['geo']['lng']
                                      .toString()),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  // here we made a our custom row component or widget, so that we make a change here and it reflects everywhere
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
