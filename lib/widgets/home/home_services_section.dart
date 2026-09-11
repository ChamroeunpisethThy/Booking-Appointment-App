// Grid of quick-access services shown on the home page.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/home_data.dart';
import 'package:booking_appointment_app/screens/appointment_screen.dart';

// Displays appointment, service, about, and contact shortcuts.
class ServicesHomeScreen extends StatelessWidget {
	final List<HomeService> services;

	const ServicesHomeScreen({super.key, this.services = HomeData.services});

	@override
	Widget build(BuildContext context) {
		// Render the section heading and the configured service cards.
		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 20),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Text(
						'Services',
						style: TextStyle(
							fontSize: 20,
							fontWeight: FontWeight.bold,
							color: Colors.black87,
						),
					),
					const SizedBox(height: 16),
					// Keep the grid inside the page's outer scroll view.
					GridView.count(
						crossAxisCount: 2,
						shrinkWrap: true,
						physics: const NeverScrollableScrollPhysics(),
						mainAxisSpacing: 16,
						crossAxisSpacing: 16,
						children: services
							.map((service) => _buildServiceCard(context, service))
							.toList(),
					),
				],
			),
		);
	}

	Widget _buildServiceCard(BuildContext context, HomeService service) {
		// Build one reusable shortcut card from a typed data record.
		return GestureDetector(
			onTap: () {
				// Open the appointment discovery screen from the Appointment shortcut.
				if (service.title == 'Appointment') {
					Navigator.push(
						context,
						MaterialPageRoute(
							builder: (_) => const AppointmentScreen(),
						),
					);
				}
			},
			child: Container(
				decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.circular(16),
					boxShadow: [
						BoxShadow(
							color: Colors.black.withOpacity(0.05),
							blurRadius: 8,
							offset: const Offset(0, 4),
						),
					],
				),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Container(
							padding: const EdgeInsets.all(16),
							decoration: const BoxDecoration(
								color: Color(0xFFE7F5F3),
								shape: BoxShape.circle,
							),
							child: Icon(
									service.icon,
								color: const Color(0xFF0D9488),
								size: 32,
							),
						),
						const SizedBox(height: 12),
						Text(
													 service.title,
							textAlign: TextAlign.center,
							style: const TextStyle(
								fontSize: 14,
								fontWeight: FontWeight.w600,
								color: Colors.black87,
							),
						),
					],
				),
			),
		);
	}
}
