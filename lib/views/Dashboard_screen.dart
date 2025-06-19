import 'package:flutter/material.dart';
import 'package:flutter_test_project/components/colors.dart';
import 'package:flutter_test_project/components/text_styles.dart';
import 'package:flutter_test_project/models/loginModel/login_response.dart';
import 'package:flutter_test_project/views/login_screen.dart';
import 'package:flutter_test_project/views/profile.dart';
import 'package:flutter_test_project/views/ticketsList.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_test_project/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create mock data for the LoginResponse model
    final mockLoginResponse = LoginResponse(
      accessToken: 'mock_token_12345',
      refreshToken: 'mock_refresh_token_67890',
      firstName: 'MockFirstName',
      lastName: 'MockLastName',
      id: 1,
      gender: 'Other',
      image: 'https://example.com/mock_image.png',
      username: 'Mock User Name',
      email: 'mockuser@example.com', // Added required email argument
      profile: Profile(
        id: 1,
        firstname: 'MockFirstName',
        middlename: 'MockMiddleName',
        lastname: 'MockLastName',
        email: 'mockuser@example.com',
        type: 'admin',
        isActive: true,
      ),
      dashboard: Dashboard(
        totalTicket: 120,
        ticketOpen: 45,
        ticketClose: 75,
      ),
    );

    return MaterialApp(
      home: DashboardScreen(loginResponse: mockLoginResponse),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final LoginResponse loginResponse;

  const DashboardScreen({super.key, required this.loginResponse});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<LoginViewModel>(context, listen: false);
      viewModel.getTickets(); // Fetch tickets once the widget is built
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${widget.loginResponse.firstName}',
          style: AppTextStyles.headline,
        ),
        foregroundColor: AppColors.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradientColor,
          ),
        ),
      ),
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: 0),
            showToggleButton: false,
            theme: SidebarXTheme(
              decoration: BoxDecoration(
                gradient: AppColors.gradientColor.withOpacity(0.8),
              ),
              width: 60,
              textStyle: TextStyle(
                color: AppColors.backgroundColor,
                fontStyle: AppTextStyles.bodyText.fontStyle,
              ),
              selectedTextStyle:
                  const TextStyle(color: AppColors.primarySwatch),
              itemTextPadding: const EdgeInsets.all(16),
              selectedItemDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(
                icon: Icons.document_scanner_outlined,
                label: 'Products',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TicketsListScreen(category: 'Products')),
                ),
              ),
              SidebarXItem(
                icon: Icons.face,
                label: 'Profile',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(profile: widget.loginResponse.profile!)),
                ),
              ),
              SidebarXItem(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final List<String> labels = [
                    'Fragrances',
                    'Beauty',
                    'Groceries',
                    'Furniture'
                  ];
                  final List<int> counts = [
                    widget.loginResponse.dashboard?.totalTicket ?? 0,
                    widget.loginResponse.dashboard?.ticketOpen ?? 0,
                    widget.loginResponse.dashboard?.ticketClose ?? 0,
                    0, // Adjust if you have an in-progress ticket count
                  ];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketsListScreen(category: labels[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            labels[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${counts[index]}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _handleLogout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
