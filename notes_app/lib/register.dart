import 'package:flutter/material.dart';
import 'package:notes_app/login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                            content: Text('Register Success!'))
                    );
                  }
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: Text(
                    'Register',
                  style: TextStyle(color: Colors.white),
                ),
            ),
            SizedBox(height: 35),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage())
                );
              },
              child: Text(
                'Already have an account? Click Here',
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
