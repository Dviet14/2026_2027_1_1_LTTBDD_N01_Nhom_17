import 'package:flutter/material.dart';

class CenterNotification {
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    if (!context.mounted) return;

    final overlay = Overlay.of(context, rootOverlay: true);

    bool visible = true;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) {
        final colorScheme = Theme.of(overlayContext).colorScheme;

        return Positioned.fill(
          child: IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: AnimatedOpacity(
                  opacity: visible ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 340),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: colorScheme.onInverseSurface,
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorScheme.onInverseSurface,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      if (!entry.mounted) return;

      visible = false;
      entry.markNeedsBuild();

      Future.delayed(const Duration(milliseconds: 300), () {
        if (entry.mounted) {
          entry.remove();
        }
      });
    });
  }
}
