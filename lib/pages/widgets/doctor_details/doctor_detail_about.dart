import 'package:flutter/material.dart';
// Import the doctor model and API-ready doctor fields.
import 'package:booking_appointment_app/data/doctor_data.dart';

// Displays the doctor's statistics and biography.
class DoctorDetailAbout extends StatelessWidget {
  // Store the doctor selected by the user.
  final DoctorProfile doctor;

  // Create the detail-information widget for one doctor.
  const DoctorDetailAbout({super.key, required this.doctor});

  // Build all information sections below the doctor profile.
  @override
  Widget build(BuildContext context) {
    // Add vertical spacing around the complete information area.
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show the doctor's key statistics first.
          _buildStats(),
          // Keep 10px spacing before the About Me title.
          const SizedBox(height: 10),
          // Display the shared section title style.
          _buildSectionTitle('About Me'),
          // Separate the title from the biography text.
          const SizedBox(height: 6),
          // Use the API biography, with a short fallback for empty data.
          Text(
            doctor.about.isEmpty
                ? '${doctor.name} is a trusted ${doctor.specialty.toLowerCase()} with ${doctor.experience.toLowerCase()} of experience.'
                : doctor.about,
            style: const TextStyle(fontSize: 12, height: 1.35),
          ),
          // Keep the same 10px spacing before every next section.
          const SizedBox(height: 10),
          // Show the doctor's specialist appointment options.
          _buildSpecialistSection(),
          const SizedBox(height: 10),
          // Show the doctor's work history.
          _buildWorkExperience(),
          const SizedBox(height: 10),
          // Show the doctor's education.
          _buildEducation(),
        ],
      ),
    );
  }

  // Displays the doctor's experience, patient count, and rating in a row of cards.
  Widget _buildStats() {
    // Keep the three statistic cards in one horizontal row.
    return Row(
      children: [
        // Display the experience value from doctor data.
        _buildStat('Experience', doctor.experience),
        const SizedBox(width: 10),
        // Display the patient count from doctor data.
        _buildStat('Patients', doctor.patients),
        const SizedBox(width: 10),
        // Display the rating from doctor data.
        _buildStat('Rate', doctor.rating),
      ],
    );
  }

  // Build one statistic card with a label and value.
  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            // Experience, patient count, and rating labels
            Text(label,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade800)),
            const SizedBox(height: 4),
            // Experience, patient count, and rating values
            Text(value,
                style:
                    const TextStyle(fontSize: 14, color: Color(0xFF343A8F), fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  // Build the Specialist section and create one option per specialty.
  Widget _buildSpecialistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the specialist section title.
        _buildSectionTitle('Specialist'),
        const SizedBox(height: 10),
        // Split combined specialties such as "Cardiologist and Surgeon".
        ...doctor.specialty
            .split(RegExp(r'\s+and\s+'))
            .map((specialist) => _buildAppointmentOption(
                  specialist.trim(),
                  doctor.price,
                )),
      ],
    );
  }

  // Build one appointment option for a specialist.
  Widget _buildAppointmentOption(String title, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFD9D9D9),
            child: Icon(Icons.medical_services_outlined,
                size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                Text(doctor.specialty, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Build the Work Experience section from the doctor's data list.
  Widget _buildWorkExperience() {
    return _buildSection(
      title: 'Work Experience',
      child: Text(
        doctor.workExperience.join('\n'),
        style: const TextStyle(fontSize: 12, height: 1.35),
      ),
    );
  }

  // Build the Education section from the doctor's data.
  Widget _buildEducation() {
    return _buildSection(
      title: 'Education',
      child: Text(
        doctor.education,
        style: const TextStyle(fontSize: 12, height: 1.35),
      ),
    );
  }

  // Build a reusable section title and white content card.
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the section title with the shared style.
        _buildSectionTitle(title),
        // Keep the title separated from its content card.
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ],
    );
  }

  // Keep every detail section title visually consistent.
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }
}
