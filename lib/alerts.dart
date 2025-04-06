import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> alerts = [
      {
        "title": "Food Available",
        "description": "Free food packets available at Shelter Point A (2 km away).",
        "time": "Just now",
        "type": "food"
      },
      {
        "title": "Road Blockage",
        "description": "Main Street near River Road is currently blocked due to flooding.",
        "time": "10 minutes ago",
        "type": "blockage"
      },
      {
        "title": "Food Available",
        "description": "Dry ration and water available at Community Center, Sector 5.",
        "time": "30 minutes ago",
        "type": "food"
      },
      {
        "title": "Road Blockage",
        "description": "Bridgeway Road is closed due to debris. Avoid the area.",
        "time": "1 hour ago",
        "type": "blockage"
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 254, 252, 252),
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
              colors: [
                Color.fromARGB(255, 190, 228, 230),
                Color.fromARGB(255, 148, 217, 227)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final isFood = alert["type"] == "food";
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                isFood ? Icons.restaurant : Icons.warning,
                color: isFood ? Colors.green : Colors.red,
                size: 30,
              ),
              title: Text(
                alert["title"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(alert["description"] ?? ""),
              trailing: Text(
                alert["time"] ?? "",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
