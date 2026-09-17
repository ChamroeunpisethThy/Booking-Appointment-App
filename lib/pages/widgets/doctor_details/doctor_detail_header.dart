import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/doctor_data.dart';

// Displays the doctor's hero image, identity, rating, and back button.
class DoctorDetailHeader extends StatelessWidget {
  final DoctorProfile doctor;

  const DoctorDetailHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 360,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                child: Image.network(
                  doctor.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFDCE0FF),
                    child: const Icon(
                      Icons.person,
                      size: 90,
                      color: Color(0xFF343A8F),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 36,
              child: _buildBackButton(context),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(Icons.star, color: Color(0xFFFFC62A), size: 16),
                  const SizedBox(width: 3),
                  Text(
                    '${doctor.rating} (${doctor.reviewCount} reviews)',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(doctor.specialty, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.maybePop(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.arrow_back_ios_new, size: 18),
      ),
    );
  }
}
