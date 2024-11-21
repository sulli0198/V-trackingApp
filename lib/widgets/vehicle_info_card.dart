import 'package:flutter/material.dart';
import 'package:vtracking_app/colors_all.dart';

class VehicleInfoCard extends StatelessWidget {
  final String vehicleName;
  final VoidCallback onClose;
  final VoidCallback onHideVehicle;

  const VehicleInfoCard({
    super.key,
    required this.vehicleName,
    required this.onClose,
    required this.onHideVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 120.0), // Adjust the card's position
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
              child: SizedBox(
                width: 330,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        vehicleName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'July 5, 2024 12:00 PM', // Replace with actual date and time
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Close Button Positioned at the Bottom
            Positioned(
              bottom: -15, // Adjusted to make the button overlap slightly outside the card
              left: 0,
              right: 0,
              child: Center(
                child: ClipOval(
                  child: Material(
                    color: AppColors.primaryBlue,
                    child: InkWell(
                      onTap: () {
                        onClose();
                        onHideVehicle();
                      },
                      child: const SizedBox(
                        width: 30, // Circular size
                        height: 30, // Circular size
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
