import 'package:flutter/material.dart';
import 'package:k/alerts.dart';
import 'package:k/onpressedsos.dart';
import 'package:k/precautions.dart';
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
      title: 'Hazardous App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
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

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (_isLongPressActive && mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Sos()),
        );
      }
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    _isLongPressActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light grayish background
      appBar: AppBar(
        title: const Text('Hazardous App'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(251, 128, 189, 1),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 15,
            right: 15,
            child: Center(
              child: GestureDetector(
                onLongPressStart: _handleLongPressStart,
                onLongPressEnd: _handleLongPressEnd,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF7E5F), Color(0xFFFF758C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/sos2.jpg'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 0,
            right: 0,
            child: Container(
              height: 600,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFff7eb3), Color(0xFFff758c)],
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
                childAspectRatio: 1.8, // Adjusted for better layout
                children: [
                  _buildButton('Report', const Report()),
                  _buildButton('Alerts', const Alerts()),
                  _buildButton('Shelters', const Shelters()),
                  _buildButton('Precaution', const Precautions()),
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
