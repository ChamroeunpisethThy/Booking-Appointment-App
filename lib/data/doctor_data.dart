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
  final String gender;
  final int reviewCount;
  final String about;
  final List<String> workExperience;
  final String education;

  const DoctorProfile({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.experience,
    required this.patients,
    required this.price,
    required this.gender,
    this.reviewCount = 0,
    this.about = '',
    required this.workExperience,
    required this.education,
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
    SpecialistCategory(
        name: 'Dermatologist', icon: Icons.face_retouching_natural),
    SpecialistCategory(
        name: 'Ophthalmologist', icon: Icons.visibility_outlined),
    SpecialistCategory(name: 'Psychiatrist', icon: Icons.psychology),
  ];

  static const filters = ['Most Exp', 'Top Rated', 'Male', 'Female'];

  static const doctors = [
    DoctorProfile(
      name: 'Dr. Ali Uzair',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300',
      rating: '4.9',
      experience: '10+ Years',
      patients: '100+',
      price: '100 USD',
      gender: 'Male',
      reviewCount: 96,
      about:
          'Dr. Ali Uzair provides trusted cardiology and surgical care with a patient-first approach.',
      workExperience: [
        '2022 - Present: Chief Executive Officer',
        '2015 - Present: Medical Doctor of ART and Medical Aesthetic',
        '2011 - 2013: Work at Technical Officer for Maternal and Child Health and Family Planning',
      ],
      education:
          'Dr. Ali Uzair is the top most cardiologist specialist in Crist Hospital in London, UK. He achieved several awards for his wonderful contribution.',
    ),
    DoctorProfile(
      name: 'Dr. Sarah Wilson',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300',
      rating: '4.8',
      experience: '8+ Years Exp',
      patients: '90+',
      price: '80 USD',
      gender: 'Female',
      reviewCount: 88,
      about:
          'Dr. Sarah Wilson provides thoughtful cardiology care and clear treatment guidance for every patient.',
      workExperience: [
        '2018 - Present: Senior Cardiologist',
        '2014 - 2018: Cardiology Specialist',
      ],
      education: 'Doctor of Medicine, Cardiology and Cardiovascular Care.',
    ),
    DoctorProfile(
      name: 'Dr. Michael Chen',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=300',
      rating: '4.7',
      experience: '12+ Years',
      patients: '120+',
      price: '120 USD',
      gender: 'Male',
      reviewCount: 102,
      about:
          'Dr. Michael Chen combines extensive experience with attentive cardiology and surgical treatment.',
      workExperience: [
        '2016 - Present: Cardiologist and Surgeon',
        '2012 - 2016: Surgical Resident',
      ],
      education: 'Doctor of Medicine, Cardiology and General Surgery.',
    ),
    DoctorProfile(
      name: 'Dr. Emily Davis',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=300',
      rating: '4.6',
      experience: '7+ Years',
      patients: '80+',
      price: '90 USD',
      gender: 'Female',
      reviewCount: 74,
      about:
          'Dr. Emily Davis offers caring consultations and personalized cardiology treatment plans.',
      workExperience: [
        '2019 - Present: Cardiologist',
        '2015 - 2019: Cardiology Resident',
      ],
      education: 'Doctor of Medicine, Cardiology and Patient Care.',
    ),
    DoctorProfile(
      name: 'Dr. David Lee',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300',
      rating: '4.5',
      experience: '9+ Years',
      patients: '95+',
      price: '110 USD',
      gender: 'Male',
      reviewCount: 91,
      about:
          'Dr. David Lee focuses on practical, reliable cardiology care and long-term patient wellbeing.',
      workExperience: [
        '2017 - Present: Cardiologist and Surgeon',
        '2013 - 2017: Medical Officer',
      ],
      education: 'Doctor of Medicine, Cardiovascular Medicine.',
    ),
    DoctorProfile(
      name: 'Dr. Olivia Martinez',
      specialty: 'Cardiologist and Surgeon',
      imageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300',
      rating: '4.4',
      experience: '6+ Years',
      patients: '70+',
      price: '85 USD',
      gender: 'Female',
      reviewCount: 68,
      about:
          'Dr. Olivia Martinez provides supportive cardiology consultations tailored to each patient.',
      workExperience: [
        '2020 - Present: Cardiologist',
        '2016 - 2020: Clinical Cardiology Specialist',
      ],
      education: 'Doctor of Medicine, Cardiology and Clinical Medicine.',
    ),
    DoctorProfile(
      name: 'Dr. James Anderson',
      specialty: 'Biologist and Psychologist',
      imageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300',
      rating: '4.3',
      experience: '11+ Years',
      patients: '110+',
      price: '95 USD',
      gender: 'Male',
      reviewCount: 85,
      about:
          'Dr. James Anderson combines biological knowledge with psychological insight to provide comprehensive care.',
      workExperience: [
        '2010 - Present: Biologist and Psychologist',
        '2006 - 2010: Research Assistant',
      ],
      education: 'Doctor of Medicine, Biology and Psychology.',
    ),
  ];
}
