import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  String otp;
  OtpScreen({required this.otp,super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP'
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                String email = otpController.text.trim();


                if(email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Enter your OTP!')
                      )
                  );
                } else {

                  // try {
                  //   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)
                  //       .then((value){
                  //
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //             backgroundColor: Colors.green,
                  //             content: Text('Login Success!'))
                  //     );
                  //
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => HomePage()));
                  //
                  //   });
                  // } catch (err) {
                  //   print(err);
                  // }

                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text(
                'Push',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
