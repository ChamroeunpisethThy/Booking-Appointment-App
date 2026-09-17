// import 'package:flutter/material.dart';
// // Import the app's appointment models and sample data.
// import 'package:booking_appointment_app/data/appointment_data.dart';

// // Define the doctor discovery screen as a stateful widget.
// class DoctorScreen extends StatefulWidget {
//   // Create the screen widget.
//   const DoctorScreen({super.key});

//   // Create the mutable state used by this screen.
//   @override
//   State<DoctorScreen> createState() => _DoctorScreenState();
// }

// // Store selected categories and filters for the doctor screen.
// class _DoctorScreenState extends State<DoctorScreen> {
//   // Keep track of the selected specialist category.
//   int _selectedCategory = 0;

//   // Keep track of the selected doctor filter.
//   int _selectedFilter = 0;

//   // Return only doctors that match the selected category and filter.
//   List<DoctorProfile> get _visibleDoctors {
//     // Read the name of the currently selected category.
//     final category = AppointmentData.categories[_selectedCategory].name;

//     // Read the currently selected filter label.
//     final filter = AppointmentData.filters[_selectedFilter];

//     // Filter the complete doctor list and create a mutable list for sorting.
//     final doctors = AppointmentData.doctors.where((doctor) {
//       // Treat the All category as matching every specialty.
//       final matchesCategory = category == 'All' ||
//           doctor.specialty.toLowerCase().contains(category.toLowerCase());

//       // Apply gender filtering only when Male or Female is selected.
//       final matchesGender =
//           filter != 'Male' && filter != 'Female' || doctor.gender == filter;

//       // Keep a doctor only when both conditions are satisfied.
//       return matchesCategory && matchesGender;
//     }).toList();

//     // Sort the matching doctors by experience when Most Exp is selected.
//     if (filter == 'Most Exp') {
//       doctors.sort((a, b) => _yearsFromExperience(b.experience)
//           .compareTo(_yearsFromExperience(a.experience)));
//     // Sort the matching doctors by rating when Top Rated is selected.
//     } else if (filter == 'Top Rated') {
//       doctors.sort(
//           (a, b) => _ratingValue(b.rating).compareTo(_ratingValue(a.rating)));
//     }

//     // Return the filtered and optionally sorted doctors.
//     return doctors;
//   }

//   // Extract the first number from an experience label such as "12 years".
//   int _yearsFromExperience(String experience) {
//     // Return the parsed number, or zero when no number is available.
//     return int.tryParse(
//             RegExp(r'\d+').firstMatch(experience)?.group(0) ?? '') ??
//         0;
//   }

//   // Convert a rating label into a number for sorting.
//   double _ratingValue(String rating) => double.tryParse(rating) ?? 0;

//   // Build the complete appointment screen.
//   @override
//   Widget build(BuildContext context) {
//     // Use a pale blue background behind the appointment content.
//     return Scaffold(
//       backgroundColor: const Color(0xFFEEF2FF),
//       // Keep the screen content away from system status and navigation areas.
//       body: SafeArea(
//         // Allow the whole page to scroll vertically.
//         child: CustomScrollView(
//           slivers: [
//             // Display the title and specialist categories.
//             SliverToBoxAdapter(child: _buildHeader()),
//             // Display the horizontally scrollable filter controls.
//             SliverToBoxAdapter(child: _buildFilters()),
//             // Display the doctor list heading.
//             SliverToBoxAdapter(child: _buildDoctorHeading()),
//             // Add horizontal and bottom spacing around the doctor list.
//             SliverPadding(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
//               // Render each matching doctor as one list item.
//               sliver: SliverList.builder(
//                 // Render one empty-state item when no doctor matches.
//                 itemCount: _visibleDoctors.isEmpty ? 1 : _visibleDoctors.length,
//                 itemBuilder: (context, index) {
//                   // Show a message instead of an empty list.
//                   if (_visibleDoctors.isEmpty) {
//                     return _buildEmptyState();
//                   }

//                   // Build the doctor card for the current list index.
//                   return _buildDoctorCard(_visibleDoctors[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build the header, page title, and specialist category scroller.
//   Widget _buildHeader() {
//     return Container(
//       // Add vertical spacing inside the white header.
//       padding: const EdgeInsets.only(top: 30, bottom: 10),
//       // Give the header a white background and rounded bottom corners.
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
//       ),
//       // Stack the header content vertically.
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Keep the title row and Specialist label aligned to 20px margins.
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 // Build the back button, centered title, and trailing balance space.
//                 Row(
//                   children: [
//                     _buildIconButton(Icons.arrow_back_ios_new,
//                         () => Navigator.maybePop(context)),
//                     // Expand the title so it remains centered between both sides.
//                     const Expanded(
//                       child: Text(
//                         'Doctor Appointment',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     const SizedBox(width: 42),
//                   ],
//                 ),
//                 // Separate the title row from the section label.
//                 const SizedBox(height: 20),
//                 // Align the Specialist label to the left side.
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Specialist',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Separate the label from the category list.
//           const SizedBox(height: 14),
//           // Give the category scroller a fixed height for stable layout.
//           SizedBox(
//             height: 96,
//             child: ListView.separated(
//               // Make categories scroll horizontally.
//               scrollDirection: Axis.horizontal,
//               // Keep 20px at both ends; this padding scrolls with the content.
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               // Create one item for every available specialist category.
//               itemCount: AppointmentData.categories.length,
//               // Add 8px between adjacent category items.
//               separatorBuilder: (_, __) => const SizedBox(width: 8),
//               // Build the category widget for each item.
//               itemBuilder: (context, index) {
//                 return _buildCategory(AppointmentData.categories[index], index);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build one specialist category as a circular icon with a label.
//   Widget _buildCategory(SpecialistCategory category, int index) {
//     // Check whether this category is currently selected.
//     final selected = _selectedCategory == index;

//     // Make the complete category area respond to taps.
//     return GestureDetector(
//       // Update the selected category and rebuild the doctor list.
//       onTap: () => setState(() => _selectedCategory = index),
//       child: SizedBox(
//         // Keep every category the same width.
//         width: 62,
//         // Stack the icon above its text label.
//         child: Column(
//           children: [
//             // Draw the circular category icon background.
//             Container(
//               width: 62,
//               height: 62,
//               decoration: BoxDecoration(
//                 // Highlight the selected category with a light indigo color.
//                 color:
//                     selected ? const Color(0xFFDCE0FF) : Colors.grey.shade300,
//                 // Make the icon background circular.
//                 shape: BoxShape.circle,
//                 // Add a thin outline around every category icon.
//                 border: Border.all(color: Colors.black, width: 1),
//               ),
//               // Use the icon supplied by the category data.
//               child: Icon(
//                 category.icon,
//                 // Use a darker icon color for the selected category.
//                 color:
//                     selected ? const Color(0xFF343A8F) : Colors.grey.shade700,
//                 size: 26,
//               ),
//             ),
//             // Add a small gap between the icon and category name.
//             const SizedBox(height: 5),
//             // Display the category name below the icon.
//             Text(
//               category.name,
//               // Keep long names on one line.
//               maxLines: 1,
//               // Show an ellipsis when a name does not fit.
//               overflow: TextOverflow.ellipsis,
//               // Center the category name under its icon.
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build the horizontally scrollable doctor filter controls.
//   Widget _buildFilters() {
//     return Padding(
//       // Keep the filter row aligned with the rest of the page content.
//       padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
//       child: SizedBox(
//         // Give the filter row a compact fixed height.
//         height: 28,
//         child: ListView.separated(
//           // Allow filters to scroll horizontally on narrow screens.
//           scrollDirection: Axis.horizontal,
//           // Create one chip for every filter label.
//           itemCount: AppointmentData.filters.length,
//           // Add a small gap between filter chips.
//           separatorBuilder: (_, __) => const SizedBox(width: 7),
//           // Build one filter chip at the current index.
//           itemBuilder: (context, index) {
//             // Check whether this filter is selected.
//             final selected = _selectedFilter == index;
//             return GestureDetector(
//               // Update the selected filter and rebuild the doctor list.
//               onTap: () => setState(() => _selectedFilter = index),
//               child: Container(
//                 // Add horizontal space around the filter text.
//                 padding: const EdgeInsets.symmetric(horizontal: 17),
//                 // Center the text inside the chip.
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   // Use indigo for the selected chip and white otherwise.
//                   color: selected ? const Color(0xFF343A8F) : Colors.white,
//                   // Round the chip corners.
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 // Display the filter label from the data list.
//                 child: Text(
//                   AppointmentData.filters[index],
//                   style: TextStyle(
//                     // Use white text on the selected chip.
//                     color: selected ? Colors.white : Colors.grey.shade500,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // Build the heading above the doctor results.
//   Widget _buildDoctorHeading() {
//     return const Padding(
//       // Align the heading with the doctor cards and add bottom spacing.
//       padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//       // Display the doctor list title.
//       child: Text(
//         'List of Doctors',
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//       ),
//     );
//   }

//   // Build one doctor result card.
//   Widget _buildDoctorCard(DoctorProfile doctor) {
//     return Container(
//       // Separate this card from the next card.
//       margin: const EdgeInsets.only(bottom: 10),
//       // Add space between the card edge and its contents.
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         // Use a white card against the pale blue page background.
//         color: Colors.white,
//         // Round the card corners.
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: Row(
//         children: [
//           // Display the doctor's profile image.
//           _buildDoctorImage(doctor.imageUrl),
//           // Separate the image from the doctor details.
//           const SizedBox(width: 10),
//           // Let the doctor details use the remaining horizontal space.
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Display the doctor's name.
//                 Text(doctor.name,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w700)),
//                 // Add space below the name.
//                 const SizedBox(height: 3),
//                 // Display the doctor's specialty.
//                 Text(doctor.specialty, style: const TextStyle(fontSize: 10)),
//                 // Add space before the metadata badges.
//                 const SizedBox(height: 9),
//                 // Keep the metadata badges together and allow wrapping.
//                 Wrap(
//                   spacing: 4,
//                   children: [
//                     // Show the doctor's patient count.
//                     _buildBadge(doctor.patients),
//                     // Show the doctor's experience.
//                     _buildBadge(doctor.experience),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Align rating, price, and booking action to the right.
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               // Display the rating and appointment price in one row.
//               Row(
//                 children: [
//                   // Show the star rating icon.
//                   const Icon(Icons.star, color: Color(0xFFFFC62A), size: 18),
//                   // Add a small gap before the rating value.
//                   const SizedBox(width: 3),
//                   // Display the doctor's rating.
//                   Text(doctor.rating, style: const TextStyle(fontSize: 12)),
//                   // Separate the rating from the price.
//                   const SizedBox(width: 10),
//                   // Display the appointment price.
//                   Text(
//                     doctor.price,
//                     style: const TextStyle(
//                       color: Color(0xFF343A8F),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//               // Add space between the price row and the booking button.
//               const SizedBox(height: 10),
//               // Create the button that starts the booking interaction.
//               ElevatedButton(
//                 // Show a confirmation message when the button is pressed.
//                 onPressed: () => _showBookingMessage(doctor),
//                 style: ElevatedButton.styleFrom(
//                   // Use the app's indigo color for the button.
//                   backgroundColor: const Color(0xFF343A8F),
//                   // Use white text and icon color on the button.
//                   foregroundColor: Colors.white,
//                   // Keep the button compact but stable in size.
//                   minimumSize: const Size(68, 32),
//                   // Add horizontal space around the button label.
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   // Round the button corners.
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   // Remove the default button shadow.
//                   elevation: 0,
//                 ),
//                 // Label the action clearly.
//                 child: const Text('Book', style: TextStyle(fontSize: 11)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Build the doctor's circular profile image.
//   Widget _buildDoctorImage(String imageUrl) {
//     return ClipOval(
//       // Load the image from the URL supplied by the doctor data.
//       child: Image.network(
//         imageUrl,
//         // Set a fixed width for the profile image.
//         width: 64,
//         // Set a fixed height for the profile image.
//         height: 64,
//         // Crop the image to fill the circular area.
//         fit: BoxFit.cover,
//         // Show a local placeholder when the network image fails.
//         errorBuilder: (_, __, ___) => Container(
//           width: 64,
//           height: 64,
//           // Use a light indigo placeholder background.
//           color: const Color(0xFFDCE0FF),
//           // Show a person icon when no image is available.
//           child: const Icon(Icons.person, color: Color(0xFF343A8F)),
//         ),
//       ),
//     );
//   }

//   // Build the message shown when no doctor matches the current selections.
//   Widget _buildEmptyState() {
//     return Container(
//       // Give the empty-state message comfortable internal spacing.
//       padding: const EdgeInsets.all(24),
//       // Center the message in the available card area.
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         // Match the white doctor-card appearance.
//         color: Colors.white,
//         // Round the empty-state card corners.
//         borderRadius: BorderRadius.circular(22),
//       ),
//       // Tell the user why no doctor cards are displayed.
//       child: const Text('No doctors match these filters.'),
//     );
//   }

//   // Build a compact metadata badge for a doctor card.
//   Widget _buildBadge(String label) {
//     return Container(
//       // Add space around the badge text.
//       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
//       decoration: BoxDecoration(
//         // Use a light blue badge background.
//         color: const Color(0xFFD9EDFF),
//         // Slightly round the badge corners.
//         borderRadius: BorderRadius.circular(8),
//       ),
//       // Display the supplied patient or experience label.
//       child:
//           Text(label, style: const TextStyle(color: Colors.blue, fontSize: 8)),
//     );
//   }

//   // Build the outlined back button used in the header.
//   Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
//     return InkWell(
//       // Run the supplied callback when the button is tapped.
//       onTap: onPressed,
//       // Keep the tap highlight aligned with the rounded button shape.
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         // Set a fixed button width.
//         width: 42,
//         // Set a fixed button height.
//         height: 42,
//         decoration: BoxDecoration(
//           // Draw a light outline around the button.
//           border: Border.all(color: Colors.grey.shade300),
//           // Round the button corners.
//           borderRadius: BorderRadius.circular(10),
//         ),
//         // Display the icon passed to this helper.
//         child: Icon(icon, size: 18),
//       ),
//     );
//   }

//   // Show temporary feedback after the user taps Book.
//   void _showBookingMessage(DoctorProfile doctor) {
//     // Display the message at the bottom of the current screen.
//     ScaffoldMessenger.of(context).showSnackBar(
//       // Include the selected doctor's name in the confirmation.
//       SnackBar(content: Text('Booking selected for ${doctor.name}')),
//     );
//   }
// }
