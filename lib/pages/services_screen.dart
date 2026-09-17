import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/services_data.dart';

// Displays the service catalog shown from the home Services shortcut.
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildFilters()),
            SliverToBoxAdapter(child: _buildHeading()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList.builder(
                itemCount: ServicesData.services.length,
                itemBuilder: (context, index) =>
                    _buildServiceCard(ServicesData.services[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildIconButton(
                Icons.arrow_back_ios_new, () => Navigator.maybePop(context)),
            const Expanded(
              child: Text(
                'Service Care',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 42),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: SizedBox(
        height: 28,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: ServicesData.filters.length,
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
                  ServicesData.filters[index],
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

  Widget _buildHeading() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(
        'List of Service',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildServiceCard(MedicalService service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          _buildServiceImage(service.imageUrl),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text('Best for age: ${service.age}',
                    style: const TextStyle(fontSize: 12)),
                Text('Gender: ${service.gender}',
                    style: const TextStyle(fontSize: 12)),
                Text('Include: ${service.included}',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                service.price,
                style: const TextStyle(
                  color: Color(0xFF343A8F),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _showBookingMessage(service),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF343A8F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(68, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Booking', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceImage(String imageUrl) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
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

  void _showBookingMessage(MedicalService service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking selected for ${service.name}')),
    );
  }
}
