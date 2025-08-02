import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';

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
              onPressed: () async {
                String userOtp = otpController.text.trim();


                if(userOtp.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Enter your OTP!')
                      )
                  );
                } else {

                  PhoneAuthCredential credential = PhoneAuthProvider
                      .credential(
                      verificationId: widget.otp,
                      smsCode: userOtp);

                  await FirebaseAuth.instance.signInWithCredential(credential)
                      .then((value){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  });


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
