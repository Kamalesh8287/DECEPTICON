import 'package:flutter/material.dart';
import 'package:k/precautions2.dart';

class Precautions1 extends StatelessWidget {
  const Precautions1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Precautions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 123, 129),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton(
              context,
              '  First Aid',
              Icons.medical_services,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstAidPage()),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              'Survival Tips',
              Icons.tips_and_updates,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SurvivalTipsPage()),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              'Precautions',
              Icons.shield,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Precautions2()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 252, 83, 83),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.black26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.white), // Icon added here
          const SizedBox(width: 12), // Spacing between icon and text
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class FirstAidPage extends StatelessWidget {
  const FirstAidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid'),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.blue.shade50,
      body: const Center(
        child: Text(
          'First Aid Content Here...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SurvivalTipsPage extends StatelessWidget {
  const SurvivalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survival Tips'),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.blue.shade50,
      body: const Center(
        child: Text(
          'Survival Tips Content Here...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
