import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors_all.dart';

class ExpandableBottomAppBar extends StatefulWidget {
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;

  const ExpandableBottomAppBar({
    super.key,
    this.onLeftButtonPressed,
    this.onRightButtonPressed
  });

  @override
  State<ExpandableBottomAppBar> createState() => _ExpandableBottomAppBarState();
}

class _ExpandableBottomAppBarState extends State<ExpandableBottomAppBar> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isMiddleButtonSmall = false;
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleMiddleButtonSize() {
    setState(() {
      _isMiddleButtonSmall = !_isMiddleButtonSmall;
      if (_isMiddleButtonSmall) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Button - Zoom Out
                FloatingActionButton(
                  backgroundColor: AppColors.primaryBlue,
                  onPressed: () {
                    if (widget.onLeftButtonPressed != null) {
                      widget.onLeftButtonPressed!();
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 100),
                // Right Button - Zoom In
                FloatingActionButton(
                  backgroundColor: AppColors.primaryBlue,
                  onPressed: () {
                    if (widget.onRightButtonPressed != null) {
                      widget.onRightButtonPressed!();
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: ScaleTransition(
              scale: _sizeAnimation,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryBlue,
                onPressed: () {
                  _toggleExpand();
                  _toggleMiddleButtonSize();
                },
                child: Icon(
                  _isExpanded ? Icons.navigation : Icons.navigation_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}