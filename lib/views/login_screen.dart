import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utils/NavigationUtils.dart';
import 'package:flutter_test_project/views/Dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../components/colors.dart';
import '../components/text_styles.dart';
import '../view_models/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Login', style: AppTextStyles.headline),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 24),
              if (viewModel.errorMessage != null)
                Text(
                  viewModel.errorMessage!,
                  style: AppTextStyles.errorText,
                ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  // Validate input fields
                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }

                  // final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  // if (!emailRegex.hasMatch(email)) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content: Text('Please enter a valid email address.')),
                  //   );
                  //   return;
                  // }

                  final loginResponse = await viewModel.login(email, password);
if (viewModel.isLoggedIn) {
  NavigationUtils.push(
    context,
    DashboardScreen(loginResponse: loginResponse),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(viewModel.errorMessage ?? 'Login failed.'),
    ),
  );
}

                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppColors.gradientColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: viewModel.isLoading
                      ? CircularProgressIndicator(
                          color: AppColors.backgroundColor)
                      : Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
