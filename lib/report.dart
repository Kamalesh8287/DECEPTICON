import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '"REPORT HERE"',
              style: TextStyle(
                fontSize: 39,
                fontWeight: FontWeight.w900,
                color: Color(0xFFD32F2F),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _navigateToReportPage('Missing Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Missing Report', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToReportPage('Transportation disruptions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Transportation disruptions', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToReportPage('Others'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Other Issues', style: TextStyle(fontSize: 20, color: Colors.white)),
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
    } else if (reportType == 'Transportation disruptions') {
      return const BlockageForm();
    } else {
      return const OtherIssuesForm();
    }
  }
}

class MissingReportForm extends StatefulWidget {
  const MissingReportForm({super.key});

  @override
  State<MissingReportForm> createState() => _MissingReportFormState();
}

class _MissingReportFormState extends State<MissingReportForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? imageUrl;

        if (_selectedImage != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('missing_reports/${DateTime.now().millisecondsSinceEpoch}.jpg');

          final uploadTask = await storageRef.putFile(_selectedImage!);
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        final reportData = {
          'name': _nameController.text,
          'age': _ageController.text,
          'last_seen_location': _locationController.text,
          'description': _descriptionController.text,
          'image_url': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance.collection('missing_reports').add(reportData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Missing report submitted successfully!')),
        );

        _nameController.clear();
        _ageController.clear();
        _locationController.clear();
        _descriptionController.clear();
        setState(() => _selectedImage = null);

        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
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
        'Description of Missing Person': _descriptionController,
      },
      selectedImage: _selectedImage,
      onImagePick: _pickImage,
      onSubmit: _submitReport,
    );
  }
}

class BlockageForm extends StatefulWidget {
  const BlockageForm({super.key});

  @override
  State<BlockageForm> createState() => _RoadBlockageFormState();
}

class _RoadBlockageFormState extends State<BlockageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _severity;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? imageUrl;

        if (_selectedImage != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('transportation_disruptions/${DateTime.now().millisecondsSinceEpoch}.jpg');

          final uploadTask = await storageRef.putFile(_selectedImage!);
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        final reportData = {
          'location': _locationController.text,
          'description': _descriptionController.text,
          'severity': _severity ?? 'Unspecified',
          'image_url': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance.collection('transportation_disruptions').add(reportData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transportation report submitted successfully!')),
        );

        _locationController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedImage = null;
          _severity = null;
        });

        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReportFormTemplate(
      formKey: _formKey,
      controllers: {
        'Location': _locationController,
        'Description': _descriptionController,
      },
      dropdownValue: _severity,
      onDropdownChanged: (value) => setState(() => _severity = value),
      selectedImage: _selectedImage,
      onImagePick: _pickImage,
      onSubmit: _submitReport,
    );
  }
}

class OtherIssuesForm extends StatefulWidget {
  const OtherIssuesForm({super.key});

  @override
  State<OtherIssuesForm> createState() => _OtherIssuesFormState();
}

class _OtherIssuesFormState extends State<OtherIssuesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? imageUrl;

        if (_selectedImage != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('report_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

          final uploadTask = await storageRef.putFile(_selectedImage!);
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        final reportData = {
          'location': _locationController.text,
          'description': _descriptionController.text,
          'image_url': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance.collection('reports').add(reportData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully!'), backgroundColor: Colors.green),
        );

        _locationController.clear();
        _descriptionController.clear();
        setState(() => _selectedImage = null);

        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReportFormTemplate(
      formKey: _formKey,
      controllers: {
        'Location': _locationController,
        'Description': _descriptionController,
      },
      selectedImage: _selectedImage,
      onImagePick: _pickImage,
      onSubmit: _submitReport,
    );
  }
}

class ReportFormTemplate extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final File? selectedImage;
  final VoidCallback onImagePick;
  final VoidCallback onSubmit;
  final String? dropdownValue;
  final Function(String?)? onDropdownChanged;

  const ReportFormTemplate({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.selectedImage,
    required this.onImagePick,
    required this.onSubmit,
    this.dropdownValue,
    this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Form'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (onDropdownChanged != null)
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    hint: const Text('Select Severity'),
                    onChanged: onDropdownChanged,
                    items: [
                      'Minor',
                      'Medium',
                      'Major',
                      'Critical',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                  ),
                if (onDropdownChanged != null) const SizedBox(height: 20),
                ...controllers.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: entry.key,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? '${entry.key} is required'
                          : null,
                    ),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: onImagePick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Upload Image', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                if (selectedImage != null) ...[
                  const SizedBox(height: 10),
                  Image.file(selectedImage!, height: 150, width: 150, fit: BoxFit.cover),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
