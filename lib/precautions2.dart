import 'package:flutter/material.dart';

class Precautions2 extends StatelessWidget {
  const Precautions2({super.key});

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
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView( // <-- Added to make the list scrollable
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            _buildButton(context, 'Cyclone Precautions', 'Cyclone Precautions Content'),
            _buildButton(context, 'Earthquake Precautions', 'Earthquake Precautions Content'),
            _buildButton(context, 'Flood Precautions', 'Flood Precautions Content'),
            _buildButton(context, 'Fire Precautions', 'Fire Precautions Content'),
            _buildButton(context, 'Tsunami Precautions', 'Tsunami Precautions Content'),
            const SizedBox(height: 20), // Added padding at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrecautionDetails(title: text, content: content),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PrecautionDetails extends StatelessWidget {
  final String title;
  final String content;

  const PrecautionDetails({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
