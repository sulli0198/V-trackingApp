import 'package:flutter/material.dart';

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
    return BottomAppBar(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_isExpanded) ...[
              ElevatedButton(
                onPressed: () {
                  // Left button action
                },
                child: const Text('Left Button'),
              ),
            ],
            ElevatedButton(
              onPressed: _toggleExpand,
              child: _isExpanded ? const Text('Collapse') : const Text('Expand'),
            ),
            if (_isExpanded) ...[
              ElevatedButton(
                onPressed: () {
                  // Right button action
                },
                child: const Text('Right Button'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
