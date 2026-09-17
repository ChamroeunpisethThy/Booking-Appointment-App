import 'package:flutter/material.dart';
// Import the doctor model used by this screen.
import 'package:booking_appointment_app/data/doctor_data.dart';
import 'package:booking_appointment_app/pages/widgets/doctor_details/doctor_detail_about.dart';
import 'package:booking_appointment_app/pages/widgets/doctor_details/doctor_detail_booking_button.dart';
import 'package:booking_appointment_app/pages/widgets/doctor_details/doctor_detail_header.dart';

// Display the full profile and appointment information for one doctor.
class DoctorDetailsScreen extends StatelessWidget {
  // Store the doctor selected from the doctor list.
  final DoctorProfile doctor;

  // Create the detail screen with the selected doctor.
  const DoctorDetailsScreen({super.key, required this.doctor});

  // Build the complete doctor details page.
  @override
  Widget build(BuildContext context) {
    // Use the app's pale blue background.
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      // Overlay the fixed booking button on top of the scrollable content.
      body: Stack(
        children: [
          // Allow all doctor information to scroll vertically.
          SingleChildScrollView(
            // Reserve space so the fixed booking button does not cover content.
            padding: const EdgeInsets.only(bottom: 84),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Render the profile first, followed by the detail sections.
              children: [
                DoctorDetailHeader(doctor: doctor),
                // Keep the lower sections aligned with 20px side margins.
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoctorDetailAbout(doctor: doctor),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Keep the booking button fixed near the bottom of the screen.
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: DoctorDetailBookingButton(doctor: doctor),
          ),
        ],
      ),
    );
  }
}
