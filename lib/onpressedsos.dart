import 'package:flutter/material.dart';

class Sos extends StatelessWidget {
  const Sos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Request Reached'),
          backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        ),
        body: Stack(
          children: [
            // Centered message
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Your request has been received.\n Please wait for a response.',

                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // Positioned CircleAvatar
            Positioned(
              top: 50, // Move down
              left: 15,
              right: 15,
              child: const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.cyanAccent,
                backgroundImage: AssetImage('assets/sos2.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
