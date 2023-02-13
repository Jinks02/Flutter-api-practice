import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api tut 3'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    // run progress indicator until it fetches and displays data
                    return const CircularProgressIndicator();
                  } else {}
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                ReusableRow(
                                    title: 'Name : ',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableRow(
                                    title: 'Username : ',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusableRow(
                                    title: 'Email : ',
                                    value:
                                        snapshot.data![index].email.toString()),
                                ReusableRow(
                                    title: 'Address : ',
                                    value: snapshot.data![index].address!.city
                                            .toString() +
                                        snapshot.data![index].address!.geo!.lat
                                            .toString() +
                                        snapshot.data![index].address!.geo!.lng
                                            .toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          )
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
