import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:k/alerts.dart';
import 'package:k/firebase_options.dart';
import 'package:k/loginpage.dart';
import 'package:k/onpressedsos.dart';
import 'package:k/precautions1.dart';
import 'package:k/report.dart';
import 'package:k/shelters.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass the API key to the AndroidManifest dynamically
  const MethodChannel(
    'flutter/config',
  ).invokeMethod('setApiKey', dotenv.env['API_KEY']);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      debugShowCheckedModeBanner: false,
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

    Future.delayed(const Duration(milliseconds: 1000), () {
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
      backgroundColor: const Color.fromARGB(255, 254, 230, 228),
      appBar: AppBar( 
        title: const Text(
          'DEBBA DEBBA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneAuthPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(59, 248, 248, 244),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 246, 245, 245),
                ),
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF2637E), Color(0xFFF23D3D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100,
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
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF3B3B), Color(0xFFD32F2F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD32F2F),
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
                    'In case of Emergency...\nHold this button',
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            child: Container(
              height: 600,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF95343), Color(0xFFF5BF90)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 500),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(33),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40,
                    childAspectRatio: 2.3,
                    children: [
                      _buildButton('Report', Icons.report, const Report()),
                      _buildButton(
                        'Alerts',
                        Icons.notification_important,
                        const Alerts(),
                      ),
                      _buildButton('Shelters', Icons.map, const Shelters()),
                      _buildButton(
                        'Precaution',
                        Icons.warning,
                        const Precautions1(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        backgroundColor: const Color.fromARGB(255, 244, 235, 237),
        foregroundColor: const Color.fromARGB(255, 45, 44, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
