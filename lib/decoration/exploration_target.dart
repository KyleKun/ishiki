import 'package:bonfire/bonfire.dart';
import 'package:ishiki/npc/npc.dart';

class ExplorationTarget extends GameDecoration with Sensor {
  bool delivery = false;
  ExplorationTarget({required super.position})
      : super.withSprite(
          size: Vector2.all(18),
          sprite: Sprite.load(
            'indicator.png',
            srcSize: Vector2.all(175),
          ),
        );

  @override
  void onContact(GameComponent component) {
    if (component is IshikiNpc && !delivery) {
      delivery = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        component.explorationController.incrementExplorationCount();
        removeFromParent();
      });
    }
  }
}
