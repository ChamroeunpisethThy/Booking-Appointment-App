import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/appointment_data.dart';

// Appointment discovery screen built from categories, filters, and doctor data.
class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _selectedCategory = 0;
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    // Use the reference layout: white discovery header over a pale blue body.
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildFilters()),
            SliverToBoxAdapter(child: _buildDoctorHeading()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList.builder(
                itemCount: AppointmentData.doctors.length,
                itemBuilder: (context, index) {
                  return _buildDoctorCard(AppointmentData.doctors[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Header contains the back affordance, title, and specialist categories.
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconButton(Icons.arrow_back_ios_new, () => Navigator.maybePop(context)),
              const Expanded(
                child: Text(
                  'Doctor Appointment',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 42),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Specialist',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppointmentData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return _buildCategory(AppointmentData.categories[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Specialist categories are displayed as circular icons with labels below.
  Widget _buildCategory(SpecialistCategory category, int index) {
    final selected = _selectedCategory == index;

    // Category selection is ready to map to an API filter later.
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = index),
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFDCE0FF) : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Icon(
                category.icon,
                color: selected ? const Color(0xFF343A8F) : Colors.grey.shade700,
                size: 26,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Filter chips are horizontally scrollable and highlight the selected option.
  Widget _buildFilters() {
    // Filter chips mirror the segmented controls shown in the reference image.
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: SizedBox(
        height: 28,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: AppointmentData.filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 7),
          itemBuilder: (context, index) {
            final selected = _selectedFilter == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFF343A8F) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  AppointmentData.filters[index],
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Doctor list section tittle
  Widget _buildDoctorHeading() {
    // Section heading separates sorting controls from the doctor results.
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(
        'List of Doctors',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  // List of doctors card
  Widget _buildDoctorCard(DoctorProfile doctor) {
    // Each doctor card keeps identity, trust signals, price, and booking action visible.
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          _buildDoctorImage(doctor.imageUrl),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(doctor.specialty, style: const TextStyle(fontSize: 10)),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 4,
                  children: [
                    _buildBadge(doctor.patients),
                    _buildBadge(doctor.experience),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFC62A), size: 18),
                  const SizedBox(width: 3),
                  Text(doctor.rating, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 10),
                  Text(
                    doctor.price,
                    style: const TextStyle(
                      color: Color(0xFF343A8F),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _showBookingMessage(doctor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF343A8F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(68, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('View', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorImage(String imageUrl) {
    // Network images use a local visual fallback so cards remain usable offline.
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 64,
          height: 64,
          color: const Color(0xFFDCE0FF),
          child: const Icon(Icons.person, color: Color(0xFF343A8F)),
        ),
      ),
    );
  }

  Widget _buildBadge(String label) {
    // Compact metadata badge used for experience and patient totals.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFD9EDFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: Colors.blue, fontSize: 8)),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    // Small outlined control matching the reference header.
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  void _showBookingMessage(DoctorProfile doctor) {
    // Temporary interaction until booking is connected to the appointment API.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking selected for ${doctor.name}')),
    );
  }
}
