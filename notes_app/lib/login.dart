import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Email'
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password'
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                String pass = passwordController.text.trim();

                if(email.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Enter all fields required')
                      )
                  );
                } else {

                  try {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)
                        .then((value){

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Login Success!'))
                      );

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()));

                    });
                  } catch (err) {
                    print(err);
                  }

                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage())
                );
              },
              child: Text(
                'New user? Click Here',
                style: TextStyle(
                    color: Colors.blueAccent
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
