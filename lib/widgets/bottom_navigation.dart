// Bottom navigation bar used by the main application shell.
import 'package:flutter/material.dart';

/// Renders navigation destinations and reports the selected index.
class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    // Wrap the navigation bar with the app's visual container and shadow.
    return Container(
      // padding: const EdgeInsets.only(top: 35, bottom: 15, left: 15, right: 15),
      // padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      
      child: BottomNavigationBar(
        // Keep selection state in the parent while forwarding taps upward.
        currentIndex: widget.currentIndex,
        onTap: widget.onIndexChanged,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0D9488),
        unselectedItemColor: Colors.grey.shade600,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        // Define the four destinations shown in the main app shell.
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.currentIndex == 0
                    ? const Color(0xFF0D9488).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.home_outlined, size: 28),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.home, size: 28),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.currentIndex == 1
                    ? const Color(0xFF0D9488).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_month_outlined, size: 28),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_month, size: 28),
            ),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.currentIndex == 2
                    ? const Color(0xFF0D9488).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.message_outlined, size: 28),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.message, size: 28),
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.currentIndex == 3
                    ? const Color(0xFF0D9488).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person_outline, size: 28),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person, size: 28),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
