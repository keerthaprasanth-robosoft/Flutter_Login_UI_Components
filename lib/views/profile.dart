import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/loginModel/login_response.dart';
import 'package:flutter_test_project/components/colors.dart';
import 'package:flutter_test_project/components/text_styles.dart';
import 'package:flutter_test_project/views/productsList.dart';

class ProfilePage extends StatelessWidget {
  final LoginResponse profile;

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
                backgroundImage: profile.image.isNotEmpty
                    ? NetworkImage(profile.image)
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),

            // First Name
            _buildNonEditableTextField(
              label: 'First Name',
              value: profile.firstName.capitalize(),
            ),

            const SizedBox(height: 10),

            // Last Name
            _buildNonEditableTextField(
              label: 'Last Name',
              value: profile.lastName.capitalize(),
            ),

            const SizedBox(height: 10),

            // Email
            _buildNonEditableTextField(
              label: 'Email',
              value: profile.email,
            ),

            const SizedBox(height: 10),

            // Phone (Optional, mock data if not available in API)
            _buildNonEditableTextField(
              label: 'Phone',
              value: profile.username == 'admin'
                  ? 'N/A'
                  : 'N/A', // Adjust as per data availability
            ),

            const SizedBox(height: 10),

            // Type
            _buildNonEditableTextField(
              label: 'Gender',
              value: profile.gender.capitalize(),
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
