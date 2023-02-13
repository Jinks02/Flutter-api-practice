import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/ProductsModel.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  // this example is of the most complex json format

  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/d24f9761-dfba-4759-bcda-f42f3dd539b7'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Tut 5'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: getProductsApi(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      // itemCount: snapshot.data.data.length, // because the api link isnt working,it cant identify the terms of the array in the api, hence the error occurs
                      itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[Text(index.toString())],
                    );
                  });
                }),
          ),
        ],
      ),
    );
  }
}
