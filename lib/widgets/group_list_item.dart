import 'package:flutter/material.dart';
import 'package:vtracking_app/colors_all.dart';

class GroupListItem extends StatelessWidget {
  final String groupName;
  final bool isSelected;
  final VoidCallback onTap;

  const GroupListItem({
    required this.groupName,
    required this.isSelected,
    required this.onTap,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(groupName),
          onTap: onTap,
        ),
      ),
    );
  }
}





class VehicleListItem extends StatelessWidget {
  final String vehicleName;
  final VoidCallback onNavigateTap;


  const VehicleListItem({
    required this.vehicleName,
    required this.onNavigateTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
      child: Container(
        height: 160, // Increased height to accommodate new elements
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vehicleName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'date & time ', // Replace with actual date if needed
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconWithLabel(
                    icon: Icons.edit,
                    label: 'Edit',
                    onTap: () {}, // Replace with actual edit function if needed
                  ),
                  _buildIconWithLabel(
                    icon: Icons.message,
                    label: 'Command',
                    onTap: () {}, // Replace with actual command function if needed
                  ),
                  _buildIconWithLabel(
                    icon: Icons.history,
                    label: 'History',
                    onTap: () {}, // Replace with actual history function if needed
                  ),
                  _buildIconWithLabel(
                    icon: Icons.map,
                    label: 'Navigate',
                    onTap: onNavigateTap, // Navigate function to update map
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithLabel({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: AppColors.primaryBlue),
          onPressed: onTap,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}