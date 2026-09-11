// Image carousel for clinic promotions.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/home_data.dart';

// Displays promotional images with page indicators.
class PromotionHomeScreen extends StatefulWidget {
  final List<String> imageUrls;

  const PromotionHomeScreen({
    super.key,
    this.imageUrls = HomeData.promotionImageUrls,
  });

  @override
  State<PromotionHomeScreen> createState() => _PromotionHomeScreenState();
}

class _PromotionHomeScreenState extends State<PromotionHomeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // Create the controller used to move between promotion images.
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Dispose the page controller with the carousel widget.
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Render the promotion carousel and its current-page indicators.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Promotion',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Container(
              // Frame the carousel as a rounded promotional card.
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    PageView.builder(
                      // Read promotion URLs from the injected data source.
                      controller: _pageController,
                      itemCount: widget.imageUrls.length,
                      onPageChanged: (page) =>
                          setState(() => _currentPage = page),
                      itemBuilder: (context, index) => Image.network(
                        widget.imageUrls[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                          // Show a stable fallback when remote media fails.
                            const ColoredBox(
                          color: Color(0xFFD84545),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // Overlay the page position indicators on the image.
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.imageUrls.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: index == _currentPage ? 22 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: index == _currentPage
                                    ? Colors.white
                                    : Colors.white54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}