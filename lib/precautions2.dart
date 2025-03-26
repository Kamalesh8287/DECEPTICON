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
            color: Colors.white, // Changed to white
          ),
        ),
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton(context, 'Cyclone Precautions', cyclonePrecautions),
            _buildButton(context, 'Earthquake Precautions', earthquakePrecautions),
            _buildButton(context, 'Flood Precautions', floodPrecautions),
            _buildButton(context, 'Fire Precautions', firePrecautions),
            _buildButton(context, 'Tsunami Precautions', tsunamiPrecautions),
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
              builder: (context) =>
                  PrecautionDetails(title: text, content: content),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Changed to white
          ),
        ),
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.8,
            color: Colors.black87,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

// === Precaution Content ===
const String cyclonePrecautions = '''
🔴 **Before a Cyclone:**
- Secure loose objects around your house.
- Keep an emergency kit ready with food, water, and essential medicines.
- Stay informed through radio, TV, or mobile alerts.
- Evacuate low-lying areas when advised.

🟠 **During a Cyclone:**
- Stay indoors, away from windows and doors.
- Turn off gas and electricity if there is flooding.
- Keep emergency lights handy.
- Avoid using the phone except for emergencies.

🟢 **After a Cyclone:**
- Listen to official updates and advice.
- Avoid flooded areas and downed power lines.
- Check for structural damage before re-entering your house.
''';

const String earthquakePrecautions = '''
🔴 **Before an Earthquake:**
- Secure heavy furniture and appliances to walls.
- Prepare an emergency kit with essentials.
- Identify safe spots like under sturdy tables or against interior walls.

🟠 **During an Earthquake:**
- Drop, Cover, and Hold On.
- Stay away from glass, windows, and exterior walls.
- If outdoors, move to an open area away from buildings and trees.

🟢 **After an Earthquake:**
- Check for injuries and provide first aid if needed.
- Avoid damaged structures and report gas leaks.
- Stay away from the beach in case of a tsunami risk.
''';

const String floodPrecautions = '''
🔴 **Before a Flood:**
- Move valuables to higher ground.
- Stock up on non-perishable food, water, and batteries.
- Listen to flood warnings and evacuation orders.

🟠 **During a Flood:**
- Evacuate immediately if instructed.
- Avoid walking or driving through floodwaters.
- Stay on higher ground and avoid rivers.

🟢 **After a Flood:**
- Avoid contact with contaminated water.
- Disinfect water sources and dispose of spoiled food.
- Report damaged infrastructure.
''';

const String firePrecautions = '''
🔴 **Before a Fire:**
- Install smoke alarms and test them regularly.
- Keep flammable materials away from heat sources.
- Prepare an escape plan and practice it with your family.

🟠 **During a Fire:**
- Stay low to avoid smoke inhalation.
- Use a fire extinguisher if safe to do so.
- Evacuate immediately and close doors behind you.

🟢 **After a Fire:**
- Do not re-enter the building until authorities say it is safe.
- Check for structural damage and gas leaks.
- Seek medical attention if needed.
''';

const String tsunamiPrecautions = '''
🔴 **Before a Tsunami:**
- Know the tsunami warning signs (earthquake, sudden ocean withdrawal).
- Have an evacuation plan for reaching high ground.

🟠 **During a Tsunami:**
- Move to higher ground immediately.
- Stay away from beaches and rivers.
- Follow evacuation orders without delay.

🟢 **After a Tsunami:**
- Wait for official updates before returning.
- Check for structural damage and gas leaks.
- Report missing people to authorities.
''';
