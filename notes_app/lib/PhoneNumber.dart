import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/OtpScreen.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/register.dart';

class PhoneNumber extends StatelessWidget {
  PhoneNumber({super.key});

  final phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Phone Number'
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                String number = phoneNumberController.text.trim();


                if(number.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Enter your phone number!')
                      )
                  );
                } else {

                  //Send OTP to the number
                  await FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted: (creadential){},
                        verificationFailed: (error){},
                        codeSent: (otp,token){

                          // After sending OTP navigate to next page.
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => OtpScreen(otp: otp))

                          );
                        },
                        codeAutoRetrievalTimeout: (otp){} ,phoneNumber: number);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent),
              child: Text(
                'Get OTP',
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
