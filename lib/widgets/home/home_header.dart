// Header showing clinic identity, greeting, notifications, and menu actions.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/home_data.dart';

/// Reusable home header with optional interaction callbacks.
class HeaderHomeScreen extends StatelessWidget {
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogoTapped;
  final String clinicName;
  final String greeting;
  final String guestName;

  const HeaderHomeScreen({
    super.key,
    this.onNotificationPressed,
    this.onMenuPressed,
    this.onLogoTapped,
    this.clinicName = HomeData.clinicName,
    this.greeting = HomeData.greeting,
    this.guestName = HomeData.guestName,
  });

  @override
  Widget build(BuildContext context) {
    // Build the branded header with identity content on the left and actions on the right.
    return Container(
      width: 750,
      padding: const EdgeInsets.only(top: 35, bottom: 15, left: 15, right: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF343A8F), Color(0xFF343A8F)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: logo, clinic name, and greeting.
          Expanded(
            child: GestureDetector(
              onTap: onLogoTapped,
              child: Row(
                children: [
                  // Logo container with a fallback icon when the asset is unavailable.
                  Container(
                    // padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'lib/assets/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.medical_services,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),

                  // Clinic name and greeting text supplied by the data layer.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clinicName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$greeting $guestName',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right side: notification and menu actions.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Notification action.
              GestureDetector(
                onTap: onNotificationPressed,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Menu action.
              GestureDetector(
                onTap: onMenuPressed,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
