import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
    } else {
      return const OtherIssuesForm(); // ✅ Added back Other Issues form
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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

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
      _selectedImage = null;

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
        'Description like clothes, height, body features':
            _descriptionController,
      },
      selectedImage: _selectedImage,
      onImagePick: _pickImage,
      onSubmit: _submitReport,
    );
  }
}

class RoadBlockageForm extends StatefulWidget {
  const RoadBlockageForm({super.key});

  @override
  State<RoadBlockageForm> createState() => _RoadBlockageFormState();
}

class _RoadBlockageFormState extends State<RoadBlockageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _severity;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

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
      _descriptionController.clear();
      _selectedImage = null;

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
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report has been submitted successfully!'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );

      _descriptionController.clear();
      _selectedImage = null;

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
                // Dropdown for Road Blockages severity
                if (onDropdownChanged != null)
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    hint: const Text('Select Severity'),
                    onChanged: onDropdownChanged,
                    items: ['Low', 'Medium', 'High']
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
                          horizontal: 15, vertical: 15),
                    ),
                  ),

                if (onDropdownChanged != null) const SizedBox(height: 20),

                // Text Fields
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${entry.key} is required';
                        }
                        return null;
                      },
                    ),
                  );
                }),

                // Image Upload Button
                ElevatedButton(
                  onPressed: onImagePick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                if (selectedImage != null) ...[
                  const SizedBox(height: 10),
                  Image.file(
                    selectedImage!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ],

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    minimumSize: const Size(double.infinity, 55), // Increased size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
