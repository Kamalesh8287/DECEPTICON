import 'package:flutter/material.dart';
import 'precautions2.dart';

void main() {
  runApp(const MaterialApp(
    home: Precautions1(),
  ));
}

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
                MaterialPageRoute(
                    builder: (context) => const SurvivalTipsPage()),
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
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 12),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _ProcedureCard(
              title: '1. Bleeding',
              steps: [
                'Apply direct pressure with a clean cloth.',
                'Elevate the injured area if possible.',
                'If bleeding does not stop, apply more pressure and seek medical help.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '2. Burns',
              steps: [
                'Cool the burn under running water for at least 10 minutes.',
                'Do not apply ice or butter.',
                'Cover with a clean, non-stick dressing.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '3. Choking',
              steps: [
                'Ask the person to cough.',
                'If they cannot cough, perform the Heimlich maneuver.',
                'If the person becomes unconscious, begin CPR.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '4. Fractures',
              steps: [
                'Keep the injured area still.',
                'Apply a splint to stabilize the area.',
                'Seek medical attention immediately.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '5. Poisoning',
              steps: [
                'Do not induce vomiting unless directed by a professional.',
                'Try to determine the type of poison.',
                'Seek medical help immediately.',
              ],
            ),
          ],
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _ProcedureCard(
              title: '1. Earthquake',
              steps: [
                'Drop to your hands and knees.',
                'Cover your head and neck with your arms.',
                'Stay away from windows and heavy objects.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '2. Flood',
              steps: [
                'Move to higher ground immediately.',
                'Avoid walking or driving through floodwaters.',
                'Listen to emergency broadcasts.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '3. Fire',
              steps: [
                'Stay low to avoid smoke inhalation.',
                'Cover your nose and mouth with a cloth.',
                'Stop, drop, and roll if your clothes catch fire.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '4. Tornado',
              steps: [
                'Seek shelter in a basement or interior room.',
                'Stay away from windows and doors.',
                'Protect your head and neck with your arms.',
              ],
            ),
            SizedBox(height: 12),
            _ProcedureCard(
              title: '5. Tsunami',
              steps: [
                'Move to higher ground immediately.',
                'Stay away from the shore.',
                'Wait for official "all clear" before returning.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProcedureCard extends StatelessWidget {
  final String title;
  final List<String> steps;

  const _ProcedureCard({
    required this.title,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ...steps.map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 18, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        step,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

