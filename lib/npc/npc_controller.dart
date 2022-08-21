import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:ishiki/npc/custom_particle.dart';

import 'npc.dart';

class NpcController extends StateController<IshikiNpc> {
  bool visible = false;
  bool lockMove = true;

  Random random = Random();
  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }

  void reset() {
    visible = false;
    lockMove = true;
  }

  @override
  void onReady(IshikiNpc component) {
    super.onReady(component);
  }

  @override
  void onRemove(IshikiNpc component) {
    super.onRemove(component);
  }

  @override
  void update(double dt, IshikiNpc component) {
    if (!visible) {
      component.size = Vector2.zero();
    } else if (component.size == Vector2.zero()) {
      component.size = Vector2(35, 35);

      gameRef.startScene(
        [
          MoveComponentSceneAction(
            component: component,
            newPosition: component.position.clone()..add(Vector2(0, 250)),
            speed: 200,
          ),
        ],
      );
    }

    if (visible && !lockMove) {
      component.seeAndMoveToPlayer(
        closePlayer: (player) {},
        observed: () {},
        radiusVision: 90,
        margin: 12,
        notObserved: () {
          component.runRandomMovement(
            dt,
            speed: component.speed / 10,
          );
        },
      );
    }

    component.position.clamp(
      Vector2(0, 0),
      gameRef.size - Vector2(40, 40),
    );

    final particleComponent = ParticleSystemComponent(
      priority: 1,
      particle: AcceleratedParticle(
        position: component.position.clone() + Vector2(17, 30),
        speed: Vector2(
          random.nextDouble() * 100 - 50,
          -random.nextDouble() * 50,
        ),
        // speed: Vector2(0, 100),
        child: ComponentParticle(
          component: TriangleComponent(),
        ),
      ),
    );

    if (!component.isIdle) component.add(particleComponent);
  }
}
