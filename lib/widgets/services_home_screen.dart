// Legacy location of the home services grid.
import 'package:flutter/material.dart';

// Displays the same quick-access services as the home widget version.
class ServicesHomeScreen extends StatelessWidget {
	const ServicesHomeScreen({super.key});

	@override
	Widget build(BuildContext context) {
		// Render the legacy services grid kept for older callers.
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
					// Keep the grid from competing with the page's outer scroll view.
					GridView.count(
						crossAxisCount: 2,
						shrinkWrap: true,
						physics: const NeverScrollableScrollPhysics(),
						mainAxisSpacing: 16,
						crossAxisSpacing: 16,
						children: [
							_buildServiceCard('Appointment', Icons.calendar_today),
							_buildServiceCard('Our Service', Icons.medical_services),
							_buildServiceCard('About Us', Icons.info_outline),
							_buildServiceCard('Contact Us', Icons.phone_in_talk),
						],
					),
				],
			),
		);
	}

	Widget _buildServiceCard(String title, IconData icon) {
		// Build one service shortcut from its display title and icon.
		return GestureDetector(
			onTap: () {
				// Connect this callback to navigation or an API action later.
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
								icon,
								color: const Color(0xFF0D9488),
								size: 32,
							),
						),
						const SizedBox(height: 12),
						Text(
							title,
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
