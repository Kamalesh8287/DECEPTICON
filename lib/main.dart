import 'package:flutter/material.dart';
import 'package:k/alerts.dart';
import 'package:k/onpressedsos.dart';
import 'package:k/precautions1.dart';
import 'package:k/report.dart';
import 'package:k/shelters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLongPressActive = false;

  void _handleLongPressStart(LongPressStartDetails details) {
    _isLongPressActive = true;

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (_isLongPressActive && mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const Sos()));
      }
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    _isLongPressActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 230, 228), // Light coral background
      appBar: AppBar(
        title: const Text(
          'Hazardous Management App',
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
              colors: [Color(0xFFF2637E), Color(0xFFF23D3D)], // Pinkish-red to red gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // SOS Button with Hold Message
          Positioned(
            top: 60,
            left: 15,
            right: 15,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onLongPressStart: _handleLongPressStart,
                    onLongPressEnd: _handleLongPressEnd,
                    child: Container(
                      width: 200,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF3B3B), Color(0xFFD32F2F)], // Brighter red to dark red gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD32F2F), // Slightly brighter red shadow
                            blurRadius: 25,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'In case of Emergency...\nHold this for 1.5 secs',
                    style: TextStyle(
                      color: Color(0xFFD32F2F), // Brighter red text
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Container with Buttons
          Positioned(
            top: 430,
            left: 0,
            right: 0,
            child: Container(
              height: 600,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 248, 213, 164), Color(0xFFFFEBEE)], // Light coral to soft pink gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: GridView.count(
                padding: const EdgeInsets.all(33),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
                childAspectRatio: 2.2,
                children: [
                  _buildButton('Report', const Report()),
                  _buildButton('Alerts', const Alerts()),
                  _buildButton('Shelters', const Shelters()),
                  _buildButton('Precaution', const Precautions1()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        backgroundColor: const Color.fromARGB(255, 248, 113, 56), // Softer, deeper orange
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
