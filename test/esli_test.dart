import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_domino/oyun_domino.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('Eşli Domino: 33 dilde ad ve anlatım', () {
    expect(esliDominoConfig.title.length, 33);
    expect(esliDominoConfig.tagline.length, 33);
    for (final s in esliDominoConfig.tutorial) {
      expect(s.text.length, 33);
    }
    expect(esliDominoRules.gameId, esliDominoId);
    expect(esliDominoRules.levelCount, 100000);
  });

  test('Eşli Domino: bölümler (çift altılı ve çift dokuzlu) oyun sonuna kadar oynanır', () {
    final planner = LevelPlanner(gameId: esliDominoId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = esliDominoRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final end = TableGameRules.simulate(gl.puzzle, quick: true);
      expect(end.over, isTrue, reason: 'bölüm $lv');
    }
  }, timeout: const Timeout(Duration(minutes: 8)));
}
