import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // how to signup ( let user create account in our app using post api )
  TextEditingController emailController =
      TextEditingController(); // whatever the text is entered in email field is stored in emailController
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    try {
      Response response = await post(
          // creating our post api request, to send req to server
          Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password}); // parameters

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['id']);
        log('account created successfully');
      } else {
        log('account creation failed');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup using Post Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller:
                  emailController, // whatever the text is entered in email field is stored in emailController
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 40.0,
            ),
            TextFormField(
              obscureText: true,
              controller:
                  passwordController, // whatever the text is entered in password field is stored in passwordController
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              // this on tap not working!!!
              onTap: () {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Sign Up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
