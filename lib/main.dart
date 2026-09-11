// Application entry point and top-level screen navigation.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/widgets/loading_screen.dart';
import 'package:booking_appointment_app/widgets/signin_screen.dart';
import 'package:booking_appointment_app/widgets/bottom_navigation.dart';
import 'package:booking_appointment_app/screens/home_screen.dart';
import 'package:booking_appointment_app/screens/appointment_screen.dart';

void main() {
  // Start the Flutter application with the root stateful widget.
  runApp(const MyApp());
}

// Owns the loading, login, and home screen states for the app.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Controls which top-level screen is currently visible.
  AppScreen _currentScreen = AppScreen.loading;

  void _handleLoadingComplete() {
    // Move from the launch animation to the sign-in flow.
    setState(() {
      _currentScreen = AppScreen.login;
    });
  }

  void _handleLoginSuccess() {
    // Show the main application after a successful sign-in.
    setState(() {
      _currentScreen = AppScreen.home;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Configure app-wide title, theme, and the current root screen.
    return MaterialApp(
      title: 'BookMyTime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEEF2FF),
      ),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    // Translate the current app state into its corresponding screen widget.
    switch (_currentScreen) {
      case AppScreen.loading:
        return LoadingScreen(onLoadingComplete: _handleLoadingComplete);
      case AppScreen.login:
        return LoginScreen(onLoginSuccess: _handleLoginSuccess);
      case AppScreen.home:
        return const MainApp();
    }
  }
}

enum AppScreen { loading, login, home }

/// Provides the home content and bottom navigation destinations.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Tracks the selected destination in the bottom navigation bar.
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Keep the selected page above the shared navigation control.
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentNavIndex,
        onIndexChanged: (index) {
          // Rebuild the shell when the user selects another destination.
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    // Resolve each navigation index to its page content.
    switch (_currentNavIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AppointmentScreen();
      case 2:
        return const Center(child: Text('Messages'));
      case 3:
        return const Center(child: Text('Profile'));
      default:
        return const HomeScreen();
    }
  }
}

