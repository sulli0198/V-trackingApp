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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 550),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
          child: SizedBox(
            height: 80,
            width: 330,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vehicleName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'July 5, 2024 12:00 PM', // Replace with actual date and time
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
           bottom: 538,
           // This will position the button to overlap the card
          child: Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Material(
                color: AppColors.primaryBlue,
                child: InkWell(
                  onTap:() { onClose();
                             onHideVehicle(); // Call this when the close icon is tapped
                            },
                  child: const SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}