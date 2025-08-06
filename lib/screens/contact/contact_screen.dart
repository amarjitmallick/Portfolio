import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Dispose of the controllers when the widget is removed from the widget tree.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    // Get values from the text controllers.
    final String name = _nameController.text;
    final String userEmail = _emailController.text;
    final String message = _messageController.text;

    // Define the recipient email address.
    const String recipientEmail = 'mallickamarjit@gmail.com';
    const String subject = 'Inquiry from Portfolio Website';

    // Construct the email body.
    final String body =
        'Name: $name\n'
        'Email: $userEmail\n\n'
        'Message:\n$message';

    // Encode the subject and body to be URL-safe.
    final String encodedSubject = Uri.encodeComponent(subject);
    final String encodedBody = Uri.encodeComponent(body);

    // Create the mailto URI.
    final Uri emailLaunchUri = Uri.parse('mailto:$recipientEmail?subject=$encodedSubject&body=$encodedBody');

    // Attempt to launch the email URI.
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        // Show an error message if the email client cannot be launched.
        _showSnackBar('Could not launch email client. Please ensure you have an email app configured.');
      }
    } catch (e) {
      // Catch any exceptions during the launch process.
      _showSnackBar('An error occurred: $e');
    }
  }

  // Helper function to show a SnackBar message.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        spacing: isMobile ? 20 : 200,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Contact Me",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Text(
                "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions. Feel free to reach out!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(
            height: 600,
            width: isMobile ? double.infinity : 700,
            child: Column(
              spacing: 20,
              children: [
                _buildTextField(label: "Your Name", controller: _nameController),
                _buildTextField(label: "Your Email", controller: _emailController),
                _buildTextField(label: "Your Message", maxLines: 5, controller: _messageController),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFDBE8F2),
                  ),
                  onPressed: _launchEmail,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    child: const Text(
                      "Send Message",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, int maxLines = 1, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.grey[100],
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
