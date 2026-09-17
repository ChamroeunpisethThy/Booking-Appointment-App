// Main scrollable home page composed of reusable content sections.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/screens/home/widgets/home_blogs_section.dart';
import 'package:booking_appointment_app/screens/home/widgets/home_header.dart';
import 'package:booking_appointment_app/screens/home/widgets/home_promotion_section.dart';
import 'package:booking_appointment_app/screens/home/widgets/home_services_section.dart';
import 'package:booking_appointment_app/screens/home/widgets/home_search_bar.dart';

// Displays the clinic header, search field, services, promotions, and posts.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Compose the home page as one vertically scrollable content feed.
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section with clinic identity and actions.
              _buildHeader(),
              const SizedBox(height: 20),
              // Search field for filtering or finding home content.
              const HomeSearchBar(),
              const SizedBox(height: 28),
              // Quick-access service shortcuts.
              const ServicesHomeScreen(),
              const SizedBox(height: 28),
              // Promotional clinic content.
              const PromotionHomeScreen(),
              const SizedBox(height: 28),
              // Community posts and engagement actions.
              const HomeBlogsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Connect header actions to the home screen callbacks.
    return HeaderHomeScreen(
      onNotificationPressed: () {
        // Handle notification tap
      },
      onMenuPressed: () {
        // Handle menu tap
      },
      onLogoTapped: () {
        // Refresh the local screen state and give the user feedback.
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Home refreshed'),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

}
