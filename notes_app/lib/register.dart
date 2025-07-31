import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
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
                onPressed: () async {
                  String mail = emailController.text.trim();
                  String pass = passwordController.text.trim();

                  if(mail.isEmpty || pass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Enter all fields required')
                        )
                    );
                  } else {

                    try {
                      //FIREBASE AUTH
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: pass)
                          .then((value){

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Register Successfully!')));

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage())
                        );

                      });
                    } catch (err) {
                      print(err);
                    }
                    emailController.text = "";
                    passwordController.text = "";
                  }
                }, //onPress; ()
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
