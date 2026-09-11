import 'package:flutter/material.dart';

// Mock home data and typed models. Replace these values with API mapping later.

// Represents one community post shown in the home feed.
class HomePost {
  final int id;
  final String author;
  final String authorSubtitle;
  final String description;
  final String imageUrl;
  final int likes;
  final int views;

  const HomePost({
    required this.id,
    required this.author,
    required this.authorSubtitle,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.views,
  });
}

// Represents one quick-access service shown on the home page.
class HomeService {
  final String title;
  final IconData icon;

  const HomeService({required this.title, required this.icon});
}

// Central source for content currently rendered by the home screen.
class HomeData {
  // Header identity and greeting values.
  static const clinicName = 'SIM PHALLY CLINIC';
  static const greeting = 'Welcome,';
  static const guestName = 'Guest 002';

  // Promotion media displayed by the home promotion section.
  static const promotionImageUrls = [
    'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=1200',
    'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=1200',
    'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=1200',
    'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=1200',
  ];

  // Quick-access actions displayed in the services grid.
  static const services = [
    HomeService(title: 'Appointment', icon: Icons.calendar_today),
    HomeService(title: 'Our Service', icon: Icons.medical_services),
    HomeService(title: 'About Us', icon: Icons.info_outline),
    HomeService(title: 'Contact Us', icon: Icons.phone_in_talk),
  ];

  // Community posts displayed in the blog section.
  static const posts = [
    HomePost(
      id: 0,
      author: 'SimPhally Clinic',
      authorSubtitle: 'Today at 9:30 AM',
      description:
          'Small daily habits can make a big difference to your heart health. Keep moving, stay hydrated, and make time for regular checkups.',
      imageUrl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=900&q=80',
      likes: 248,
      views: 1840,
    ),
    HomePost(
      id: 1,
      author: 'BookMyTime Health',
      authorSubtitle: 'Yesterday at 4:15 PM',
      description:
          'Your next appointment is a simple step toward feeling your best. Book a consultation with a specialist you can trust.',
      imageUrl:
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=900&q=80',
      likes: 126,
      views: 962,
    ),
  ];
}
