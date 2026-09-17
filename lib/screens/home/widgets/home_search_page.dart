import 'package:flutter/material.dart';
// Import the local doctor records used by search results.
import 'package:booking_appointment_app/data/doctor_data.dart';
// Import the local service records used by search results.
import 'package:booking_appointment_app/data/services_data.dart';
// Import the screen opened when a doctor result is selected.
import 'package:booking_appointment_app/pages/doctors_screen.dart';
// Import the screen opened when a service result is selected.
import 'package:booking_appointment_app/pages/services_screen.dart';

// Provide a full-screen search experience for doctors and medical services.
class HomeSearchScreen extends StatefulWidget {
  // Create the search screen.
  const HomeSearchScreen({super.key});

  // Create the mutable state for the search screen.
  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

// Manage the search query, suggestions, and results.
class _HomeSearchScreenState extends State<HomeSearchScreen> {
  // Control the text entered in the search field.
  final _searchController = TextEditingController();

  // Provide suggested specialties shown before the user types.
  static const _specialties = [
    'Cardiologist',
    'Obstetrician and gynecologist',
    'Dermatologist',
    'Nutritionist',
    'Ophthalmologist',
    'Pulmonologist',
    'Pediatrician',
    'Psychiatrist',
    'Radiologist',
    'Cardiac surgeon',
    'Family Medicine',
  ];

  // Store the normalized search query used for matching.
  String _searchQuery = '';

  // Release the text controller when the screen is removed.
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Build the search screen and switch between suggestions and results.
  @override
  Widget build(BuildContext context) {
    // Keep only specialties that contain the current query.
    final visibleSpecialties = _specialties.where((specialty) {
      return specialty.toLowerCase().contains(_searchQuery);
    }).toList();

    // Use a white background like the search reference layout.
    return Scaffold(
      backgroundColor: Colors.white,
      // Keep the search content away from system areas.
      body: SafeArea(
        // Stack the search header and its current content vertically.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Render the search input and Cancel action.
            _buildSearchHeader(),
            // Separate the header from the content below it.
            const SizedBox(height: 30),
            // Show specialty suggestions until the user enters a query.
            if (_searchQuery.isEmpty) ...[
              // Display the specialty section heading.
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Check with Specialties',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              // Add spacing below the heading.
              const SizedBox(height: 16),
              // Let the suggested specialties scroll vertically.
              Expanded(
                child: ListView.builder(
                  // Keep the list aligned with the 20px screen inset.
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // Render one row for each matching suggestion.
                  itemCount: visibleSpecialties.length,
                  itemBuilder: (context, index) {
                    // Read the suggestion for this list position.
                    final specialty = visibleSpecialties[index];
                    // Build the tappable suggestion row.
                    return _buildSpecialty(specialty);
                  },
                ),
              ),
            ] else ...[
              // Show doctor and service results after typing.
              Expanded(child: SingleChildScrollView(child: _buildResults())),
            ],
          ],
        ),
      ),
    );
  }

  // Build the compact search field and Cancel action.
  Widget _buildSearchHeader() {
    // Keep the header content aligned with 20px horizontal padding.
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          // Let the search field use the available width.
          Expanded(
            child: SizedBox(
              // Keep the search field height stable.
              height: 40,
              child: TextField(
                // Connect the field to the screen's text controller.
                controller: _searchController,
                // Open the keyboard as soon as the screen appears.
                autofocus: true,
                // Normalize the query whenever the text changes.
                onChanged: (value) {
                  setState(() => _searchQuery = value.trim().toLowerCase());
                },
                // Show the search action on the keyboard.
                textInputAction: TextInputAction.search,
                // Use the compact search text size.
                style: const TextStyle(fontSize: 16),
                // Configure the search field appearance.
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          // Add a small gap before Cancel.
          const SizedBox(width: 6),
          // Close the search screen without changing the home screen.
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF087ED9),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build one suggested specialty row.
  Widget _buildSpecialty(String specialty) {
    return GestureDetector(
      // Use the selected specialty as the active search query.
      onTap: () {
        _searchController.text = specialty;
        setState(() => _searchQuery = specialty.toLowerCase());
      },
      child: Padding(
        // Separate this suggestion from the next one.
        padding: const EdgeInsets.only(bottom: 22),
        child: Row(
          children: [
            // Show the search icon beside the suggestion.
            const Icon(Icons.search, color: Color(0xFF64748B), size: 32),
            // Separate the icon from the suggestion text.
            const SizedBox(width: 14),
            // Let long specialty names use the remaining width.
            Expanded(
              child: Text(
                specialty,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Find doctors and services that match the normalized query.
  Widget _buildResults() {
    // Search by doctor name and specialty.
    final doctors = AppointmentData.doctors.where((doctor) {
      final searchable = '${doctor.name} ${doctor.specialty}'.toLowerCase();
      return searchable.contains(_searchQuery);
    }).toList();
    // Search by medical service name.
    final services = ServicesData.services.where((service) {
      return service.name.toLowerCase().contains(_searchQuery);
    }).toList();

    // Show an empty state when neither data source matches.
    if (doctors.isEmpty && services.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(child: Text('No doctors or services found.')),
      );
    }

    // Align result cards with the 20px screen inset.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label the combined doctor and service results.
          const Text(
            'Search Results',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          // Add space before the first result card.
          const SizedBox(height: 10),
          // Render matching doctor cards.
          ...doctors.map(_buildDoctorResult),
          // Render matching service cards after doctor cards.
          ...services.map(_buildServiceResult),
        ],
      ),
    );
  }

  // Build a result card for one doctor.
  Widget _buildDoctorResult(DoctorProfile doctor) {
    return _buildResultTile(
      // Use the doctor's profile image in the result card.
      imageUrl: doctor.imageUrl,
      // Use this icon if the doctor's image cannot load.
      fallbackIcon: Icons.person_outline,
      // Display the doctor's name and specialty.
      title: doctor.name,
      subtitle: doctor.specialty,
      // Open the full doctor screen when selected.
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DoctorsScreen()),
      ),
    );
  }

  // Build a result card for one medical service.
  Widget _buildServiceResult(MedicalService service) {
    return _buildResultTile(
      // Use the service image in the result card.
      imageUrl: service.imageUrl,
      // Use a medical-services icon if the image cannot load.
      fallbackIcon: Icons.medical_services_outlined,
      // Display the service name and price.
      title: service.name,
      subtitle: service.price,
      // Open the full service screen when selected.
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ServicesScreen()),
      ),
    );
  }

  // Build the shared visual layout for doctor and service results.
  Widget _buildResultTile({
    required String imageUrl,
    required IconData fallbackIcon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    // Use a flat card to group each search result.
    return Card(
      // Keep a small gap between result cards.
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        // Run the result-specific navigation callback when tapped.
        onTap: onTap,
        // Display the result image inside a circular frame.
        leading: ClipOval(
          child: Image.network(
            imageUrl,
            // Keep result images at a stable size.
            width: 52,
            height: 52,
            // Crop images to fill the circular frame.
            fit: BoxFit.cover,
            // Use the fallback icon if the network image fails.
            errorBuilder: (_, __, ___) => _imagePlaceholder(fallbackIcon),
          ),
        ),
        // Display the result title.
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        // Display the result subtitle.
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        // Show a navigation affordance on the right.
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  // Build a local image placeholder for failed or missing image URLs.
  Widget _imagePlaceholder(IconData icon) {
    return Container(
      // Match the network image dimensions.
      width: 52,
      height: 52,
      // Use the app's light indigo placeholder background.
      color: const Color(0xFFDCE0FF),
      // Display the supplied fallback icon.
      child: Icon(icon, color: const Color(0xFF343A8F)),
    );
  }
}
