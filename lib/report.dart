import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? _selectedReport;

  void _navigateToReportPage(String reportType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailPage(reportType: reportType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 250, 249),
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: const Color.fromARGB(255, 216, 114, 114),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '"REPORT HERE "',
              style: TextStyle(
                fontSize: 39,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 197, 89, 89),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: _selectedReport,
              hint: const Text('Select Report Type'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _navigateToReportPage(newValue);
                }
              },
              items: ['Missing Report', 'Road Blockages', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailPage extends StatelessWidget {
  final String reportType;

  const ReportDetailPage({super.key, required this.reportType});

  @override
  Widget build(BuildContext context) {
    if (reportType == 'Missing Report') {
      return const MissingReportForm();
    } else if (reportType == 'Road Blockages') {
      return const RoadBlockageForm();
    } else if (reportType == 'Others') {
      return const OtherIssuesForm();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(reportType),
        backgroundColor: const Color.fromARGB(255, 248, 113, 56),
      ),
      body: Center(
        child: Text(
          'Details of $reportType',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MissingReportForm extends StatefulWidget {
  const MissingReportForm({super.key});

  @override
  State<MissingReportForm> createState() => _MissingReportFormState();
}

class RoadBlockageForm extends StatefulWidget {
  const RoadBlockageForm({super.key});

  @override
  State<RoadBlockageForm> createState() => _RoadBlockageFormState();
}

class OtherIssuesForm extends StatefulWidget {
  const OtherIssuesForm({super.key});

  @override
  State<OtherIssuesForm> createState() => _OtherIssuesFormState();
}

class _MissingReportFormState extends State<MissingReportForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report has been submitted successfully!'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );

      _nameController.clear();
      _ageController.clear();
      _locationController.clear();
      _descriptionController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReportFormTemplate(
      formKey: _formKey,
      controllers: {
        'Name': _nameController,
        'Age': _ageController,
        'Last Seen Location': _locationController,
        'Description like clothes,height,body features': _descriptionController,
      },
      onSubmit: _submitReport,
    );
  }
}

class _RoadBlockageFormState extends State<RoadBlockageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _severityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report has been submitted successfully!'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );

      _locationController.clear();
      _severityController.clear();
      _descriptionController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReportFormTemplate(
      formKey: _formKey,
      controllers: {
        'Location': _locationController,
        'Severity': _severityController,
        'Description': _descriptionController,
      },
      onSubmit: _submitReport,
    );
  }
}

class _OtherIssuesFormState extends State<OtherIssuesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _issueTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report has been submitted successfully!'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );

      _issueTypeController.clear();
      _descriptionController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReportFormTemplate(
      formKey: _formKey,
      controllers: {
        'Issue Type': _issueTypeController,
        'Description': _descriptionController,
      },
      onSubmit: _submitReport,
    );
  }
}

class ReportFormTemplate extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onSubmit;

  const ReportFormTemplate({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: const Color.fromARGB(255, 248, 107, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var entry in controllers.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: entry.key,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter ${entry.key.toLowerCase()}' : null,
                    ),
                  ),
                const SizedBox(height: 40),
              ElevatedButton(
  onPressed: onSubmit,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF42A5F5),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  ),
  child: const SizedBox(
    width: double.infinity, // Makes the button expand to full width
    child: Center(
      child: Text(
        'Submit Report',
        style: TextStyle(
          fontSize: 18, // Set font size
          fontWeight: FontWeight.bold, // Make the text bold
          letterSpacing: 1.5, // Add spacing between letters
          color: Colors.white, // Ensure text is readable
        ),
      ),
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
