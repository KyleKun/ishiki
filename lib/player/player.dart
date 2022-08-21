import 'package:bonfire/bonfire.dart';

import 'package:ishiki/player/player_controller.dart';
import 'package:ishiki/player/spritesheet.dart';

class IshikiPlayer extends SimplePlayer
    with ObjectCollision, UseStateController<PlayerController> {
  bool startedSecondChapter = false;

  IshikiPlayer(Vector2 position)
      : super(
          position: position,
          size: Vector2(35, 35),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 0,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(35, 35),
          ),
        ],
      ),
    );
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (hasController) {
      controller.joystickAction(event);
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (hasController) {
      controller.joystickChangeDirectional(event);
    }
    super.joystickChangeDirectional(event);
  }
}
