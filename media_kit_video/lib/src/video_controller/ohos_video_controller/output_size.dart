import 'dart:math' as math;

/// Returns the rotated display size, or fits it inside an explicit output box.
(int, int)? ohosOutputSize({
  required int displayWidth,
  required int displayHeight,
  int rotation = 0,
  int? width,
  int? height,
}) {
  if (displayWidth <= 0 || displayHeight <= 0) return null;
  final swap = rotation % 180 != 0;
  final w = swap ? displayHeight : displayWidth;
  final h = swap ? displayWidth : displayHeight;
  // Preserve the existing source-size behavior without an explicit request.
  if (width == null && height == null) return (w, h);
  final boxWidth = (width ?? 4096).clamp(1, 4096);
  final boxHeight = (height ?? 4096).clamp(1, 4096);
  final scale = math.min(boxWidth / w, boxHeight / h);
  return (
    (w * scale).floor().clamp(1, boxWidth),
    (h * scale).floor().clamp(1, boxHeight),
  );
}
