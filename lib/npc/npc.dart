import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';

import '../narrator/narrator_controller.dart';
import '../player/spritesheet.dart';
import 'npc_controller.dart';

class IshikiNpc extends SimpleNpc
    with
        ObjectCollision,
        AutomaticRandomMovement,
        ChangeNotifier,
        UseStateController<NpcController> {
  bool visible = false;
  late NarratorController explorationController;
  final bool second;
  IshikiNpc(Vector2 position, {this.second = false})
      : super(
            position: position,
            // I'm sorry
            size: Vector2(0, 0),
            animation: PlayerSpriteSheet.simpleDirectionAnimation,
            speed: 200) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30, 30),
          ),
        ],
      ),
    );
  }

  @override
  void onMount() {
    explorationController = BonfireInjector.instance.get<NarratorController>();
    super.onMount();
  }
}
