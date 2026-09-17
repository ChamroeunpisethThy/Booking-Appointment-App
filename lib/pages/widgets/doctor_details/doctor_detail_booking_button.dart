import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/doctor_data.dart';

// Displays the fixed primary booking action for the selected doctor.
class DoctorDetailBookingButton extends StatelessWidget {
  final DoctorProfile doctor;

  const DoctorDetailBookingButton({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Booking selected for ${doctor.name}')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF343A8F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Book Appointment',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
