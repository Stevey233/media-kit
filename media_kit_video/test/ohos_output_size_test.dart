import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit_video/src/video_controller/ohos_video_controller/output_size.dart';

void main() {
  (int, int)? size({
    int w = 1920,
    int h = 1080,
    int r = 0,
    int? width,
    int? height,
  }) => ohosOutputSize(
    displayWidth: w,
    displayHeight: h,
    rotation: r,
    width: width,
    height: height,
  );

  test('source behavior and rotation are preserved without a request', () {
    expect(size(), (1920, 1080));
    expect(size(w: 7680, h: 4320), (7680, 4320));
    expect(size(r: 90), (1080, 1920));
    expect(size(r: 180), (1920, 1080));
    expect(size(r: 270), (1080, 1920));
    expect(size(w: 0), isNull);
  });
  test('fits the display aspect in the requested box', () {
    expect(size(width: 2880, height: 1920), (2880, 1620));
    expect(size(r: 90, width: 2880, height: 1920), (1080, 1920));
    expect(size(width: 960, height: 540), (960, 540));
    expect(size(width: 2880), (2880, 1620));
    expect(size(height: 1620), (2880, 1620));
  });
  test('caps explicit requests and handles tiny or invalid boxes', () {
    expect(size(width: 9000, height: 9000), (4096, 2304));
    expect(size(r: 270, width: 9000, height: 9000), (2304, 4096));
    expect(size(width: 0, height: -2), (1, 1));
    expect(size(width: 1, height: 1), (1, 1));
  });
}
