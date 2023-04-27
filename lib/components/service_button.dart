import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String link;
  final bool isDark;

  const ServiceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.link,
    this.isDark = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: isDark ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to the link
      },
      child: Container(
        width: 110.0,
        height: 80.0,
        margin: EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          color: isDark
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDark ? Colors.white : Colors.black,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: textStyle,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
