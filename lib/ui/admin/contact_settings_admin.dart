import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/data/models/contact_settings.dart';
import 'package:krishna/data/services/contact_settings_service.dart';
import 'package:krishna/service_locator.dart';

class ContactSettingsAdmin extends StatefulWidget {
  const ContactSettingsAdmin({super.key});

  @override
  State<ContactSettingsAdmin> createState() => _ContactSettingsAdminState();
}

class _ContactSettingsAdminState extends State<ContactSettingsAdmin> {
  final ContactSettingsService _service = locator<ContactSettingsService>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    try {
      final settings = await _service.getContactSettings();
      _emailController.text = settings.email;
      _phoneController.text = settings.phone;
      _locationController.text = settings.location;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading settings: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final settings = ContactSettings(
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        location: _locationController.text.trim(),
        lastUpdated: DateTime.now(),
      );

      await _service.updateContactSettings(settings);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact settings updated successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving settings: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Settings'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Update your contact details that will be displayed on the website.',
                                  style: TextStyle(color: AppColors.lightText),
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email Address',
                                    hintText: 'your.email@gmail.com',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    hintText: '+977 981-4777485',
                                    prefixIcon: Icon(Icons.phone_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _locationController,
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                    hintText: 'Dharan, Nepal',
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a location';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _isSaving ? null : _saveSettings,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: _isSaving
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Save Changes',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
