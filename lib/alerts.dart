

import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 254, 252, 252),
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 190, 228, 230), Color.fromARGB(255, 148, 217, 227)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
          ),
        ),
      ),
       ),
    );
  }
}
