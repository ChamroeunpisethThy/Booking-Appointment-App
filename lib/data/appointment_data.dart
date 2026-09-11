import 'package:flutter/material.dart';

// Typed appointment content kept separate from the screen for an easy API swap.
class SpecialistCategory {
  final String name;
  final IconData icon;

  const SpecialistCategory({required this.name, required this.icon});
}

// Represents one doctor card shown in the specialist list.
class DoctorProfile {
  final String name;
  final String specialty;
  final String imageUrl;
  final String rating;
  final String experience;
  final String patients;
  final String price;

  const DoctorProfile({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.experience,
    required this.patients,
    required this.price,
  });
}

// Temporary local source matching the appointment design reference.
class AppointmentData {
  static const categories = [
    SpecialistCategory(name: 'All', icon: Icons.medical_services_outlined),
    SpecialistCategory(name: 'Surgeon', icon: Icons.health_and_safety_outlined),
    SpecialistCategory(name: 'Biologist', icon: Icons.biotech_outlined),
    SpecialistCategory(name: 'Cardiologist', icon: Icons.favorite_border),
    SpecialistCategory(name: 'Dentist', icon: Icons.mood_outlined),
    SpecialistCategory(name: 'Neurologist', icon: Icons.psychology_outlined),
    SpecialistCategory(name: 'Pediatrician', icon: Icons.child_care_outlined),
    SpecialistCategory(name: 'Dermatologist', icon: Icons.face_retouching_natural),
    SpecialistCategory(name: 'Ophthalmologist', icon: Icons.visibility_outlined),
    SpecialistCategory(name: 'Psychiatrist', icon: Icons.psychology),
  ];

  static const filters = ['Most Exp', 'Top Rated', 'Male', 'Female'];

  static const doctors = [
    DoctorProfile(
      name: 'Dr. Ali Uzair',
      specialty: 'Cardiologist and Surgeon',
      imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300',
      rating: '4.9',
      experience: '10+ Years Exp',
      patients: '100+ Patients',
      price: '100 USD',
    ),
    DoctorProfile(
      name: 'Dr. Sarah Wilson',
      specialty: 'Cardiologist and Surgeon',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300',
      rating: '4.8',
      experience: '8+ Years Exp',
      patients: '90+ Patients',
      price: '80 USD',
    ),
    DoctorProfile(
      name: 'Dr. Michael Chen',
      specialty: 'Cardiologist and Surgeon',
      imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=300',
      rating: '4.7',
      experience: '12+ Years Exp',
      patients: '120+ Patients',
      price: '120 USD',
    ),
  ];
}
