import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/loginModel/login_response.dart';
import 'package:flutter_test_project/components/colors.dart';
import 'package:flutter_test_project/components/text_styles.dart';

class ProfilePage extends StatelessWidget {
  final Profile profile;

  const ProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE', style: AppTextStyles.headline),
        foregroundColor: AppColors.backgroundColor,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradientColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  ((profile.firstname != null && profile.firstname!.isNotEmpty) ? profile.firstname![0] : 'U') +
                      ((profile.lastname != null && profile.lastname!.isNotEmpty) ? profile.lastname![0] : 'U'),
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // First Name
            _buildNonEditableTextField(
              label: 'First Name',
              value: profile.firstname ?? "",
            ),

            const SizedBox(height: 10),

            // Last Name
            _buildNonEditableTextField(
              label: 'Last Name',
              value: profile.lastname ?? "",
            ),

            const SizedBox(height: 10),

            // Email
            _buildNonEditableTextField(
              label: 'Email',
              value: profile.email ?? "",
            ),

            const SizedBox(height: 10),

            // Phone (Optional, mock data if not available in API)
            _buildNonEditableTextField(
              label: 'Phone',
              value: profile.type == 'admin'
                  ? 'N/A'
                  : 'N/A', // Adjust as per data availability
            ),

            const SizedBox(height: 10),

            // Type
            _buildNonEditableTextField(
              label: 'Type',
              value: profile.type ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build non-editable text fields
  Widget _buildNonEditableTextField(
      {required String label, required String value}) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: TextEditingController(text: value),
    );
  }
}
