import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_screen.dart';
import 'view_models/login_view_model.dart';
import 'components/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: AppColors.primarySwatch),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
