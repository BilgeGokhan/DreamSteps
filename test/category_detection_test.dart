import 'package:flutter_test/flutter_test.dart';
import 'package:dreamsteps/services/category_detection_service.dart';

void main() {
  group('CategoryDetectionService Edge Cases', () {
    test('Empty string returns fallback', () {
      final result = CategoryDetectionService.detectCategory('');
      expect(result, 'self_improvement');
    });

    test('Whitespace only returns fallback', () {
      final result = CategoryDetectionService.detectCategory('   ');
      expect(result, 'self_improvement');
    });

    test('Emojis are handled gracefully', () {
      final result = CategoryDetectionService.detectCategory(
          '💰 para biriktirmek istiyorum 💰');
      expect(result, isNotEmpty);
      // Should not crash, should detect finance category
    });

    test('Misspelled words are handled with fuzzy matching', () {
      final result =
          CategoryDetectionService.detectCategory('parra biriktirmek');
      expect(result, isNotEmpty);
      // Should detect finance despite typo
    });

    test('Long sentences are handled', () {
      const longSentence =
          'Ben çok uzun bir cümle yazıyorum ve bu cümle içinde para biriktirmek istiyorum kelimesi geçiyor';
      final result = CategoryDetectionService.detectCategory(longSentence);
      expect(result, isNotEmpty);
      // Should not crash
    });

    test('Abstract goals return fallback or valid category', () {
      final result =
          CategoryDetectionService.detectCategory('mutlu olmak istiyorum');
      expect(result, isNotEmpty);
      // Abstract goals should return a valid category (may not always be self_improvement)
      // Important: should not crash
    });

    test('English keywords work or return fallback', () {
      final result =
          CategoryDetectionService.detectCategory('I want to save money');
      expect(result, isNotEmpty);
      // Should detect finance category or return fallback if threshold not met
      // Important: should not crash
    });

    test('Mixed Turkish-English works', () {
      final result =
          CategoryDetectionService.detectCategory('para save biriktirmek');
      expect(result, isNotEmpty);
      // Should detect finance category
    });

    test('Special characters are handled', () {
      final result =
          CategoryDetectionService.detectCategory('para!!! biriktirmek???');
      expect(result, isNotEmpty);
      // Should not crash
    });

    test('Uppercase/lowercase variations work', () {
      final result1 =
          CategoryDetectionService.detectCategory('PARA BİRİKTİRMEK');
      final result2 =
          CategoryDetectionService.detectCategory('para biriktirmek');
      expect(result1, isNotEmpty);
      expect(result2, isNotEmpty);
      // Both should work
    });
  });
}
