import 'package:flutter/material.dart';

import '../colors_all.dart';

class ExpandableBottomAppBar extends StatefulWidget {
  const ExpandableBottomAppBar({super.key});

  @override
  State<ExpandableBottomAppBar> createState() => _ExpandableBottomAppBarState();
}

class _ExpandableBottomAppBarState extends State<ExpandableBottomAppBar> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Remove the BottomAppBar completely and use Container instead
    return Container(
      height: 80, // Adjust this height as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: AppColors.primaryOrange,
                  onPressed: () {
                    // Left button action
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 60),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: AppColors.primaryOrange,
                  onPressed: () {
                    // Right button action
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryOrange,
              onPressed: _toggleExpand,
              child: Icon(
                _isExpanded ? Icons.navigation : Icons.navigation_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}