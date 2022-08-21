import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishiki/decoration/exploration_target.dart';
import 'package:ishiki/npc/npc.dart';
import 'package:ishiki/player/spritesheet.dart';

import 'player.dart';

class PlayerController extends StateController<IshikiPlayer> {
  bool visible = false;
  bool lockMove = true;
  bool startedSecondChapter = false;
  bool enableMerge = false;
  bool finishedMerge = false;
  bool enableSecondMerge = false;
  bool finishedSecondMerge = false;
  bool unmerge = false;
  bool unmergeSecond = false;
  bool arguing = false;
  bool killed = false;

  void reset() {
    visible = false;
    lockMove = true;
    startedSecondChapter = false;
    enableMerge = false;
    finishedMerge = false;
    enableSecondMerge = false;
    finishedSecondMerge = false;
    unmerge = false;
    unmergeSecond = false;
    arguing = false;
    killed = false;
  }

  Random random = Random();
  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }

  void startChapterTwo() {
    startedSecondChapter = true;
    visible = true;
    lockMove = false;
  }

  void addTargets() {
    gameRef.add(ExplorationTarget(position: Vector2(50, 50)));
    gameRef.add(ExplorationTarget(position: gameRef.size - Vector2(50, 50)));
    gameRef.add(ExplorationTarget(position: Vector2(50, gameRef.size.y - 50)));
    gameRef.add(ExplorationTarget(position: Vector2(gameRef.size.x - 50, 50)));
  }

  @override
  void onReady(IshikiPlayer component) {
    super.onReady(component);
  }

  @override
  void onRemove(IshikiPlayer component) {
    super.onRemove(component);
  }

  @override
  void update(double dt, IshikiPlayer component) {
    if (!visible) {
      component.size = Vector2.zero();
    } else if (component.size == Vector2.zero()) {
      component.size = Vector2(35, 35);
    }

    component.position.clamp(
      Vector2(0, 0),
      gameRef.size - Vector2(40, 40),
    );

    if ((enableMerge && !finishedMerge) ||
        (enableSecondMerge && !finishedSecondMerge)) {
      final npc = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .first;

      if (component.position.distanceTo(npc.position) < 5) {
        component.position = npc.position;
        if (enableMerge) {
          finishedMerge = true;
        }
        if (enableSecondMerge) {
          component
              .replaceAnimation(PlayerSpriteSheetTwo.simpleDirectionAnimation);
          npc.replaceAnimation(PlayerSpriteSheetTwo.simpleDirectionAnimation);
          gameRef.add(
            IshikiNpc(
              component.position
                ..clone()
                ..add(Vector2(20, -100)),
              second: true,
            ),
          );

          finishedSecondMerge = true;
        }
      }
    }

    if (unmerge) {
      unmerge = false;

      final npc = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .first;

      for (int i = 0; i < 70; i++) {
        Future.delayed(Duration(milliseconds: i * 10), () {
          npc.position = npc.position.clone()..add(Vector2(-1, -1));
        });
      }
    }

    if (unmergeSecond) {
      unmergeSecond = false;

      final npc1 = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .first;

      final npc2 = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .last;

      for (int i = 0; i < 70; i++) {
        Future.delayed(Duration(milliseconds: i * 10), () {
          if (npc1.second == true) {
            npc1.position = npc1.position.clone()..add(Vector2(-1, -1));
          } else {
            npc2.position = npc2.position.clone()..add(Vector2(-1, -1));
          }
        });
      }
    }

    if (arguing) {
      arguing = false;
      final npc1 = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .first;

      final npc2 = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .last;

      if (npc1.second == true) {
        npc1.isIdle = true;
        npc1.speed = 0;
      } else {
        npc2.isIdle = true;
        npc2.speed = 0;
      }
    }

    if (killed) {
      killed = false;
      final npc = gameRef
          .visibleComponents()
          .whereType<IshikiNpc>()
          .cast<IshikiNpc>()
          .last;
      npc.removeFromParent();
    }

    final particleComponent = ParticleSystemComponent(
      priority: 1,
      particle: AcceleratedParticle(
        position: component.position.clone() + Vector2(17, 32),
        speed: Vector2(
          random.nextDouble() * 200 - 100,
          -random.nextDouble() * 100,
        ),
        // speed: Vector2(0, 100),
        child: CircleParticle(
          radius: 1.0,
          paint: Paint()..color = Colors.white,
        ),
      ),
    );

    if (!component.isIdle && !lockMove) component.add(particleComponent);

    // if (component.checkInterval('seeEnemy', 250, dt) == true) {
    //   component.seeEnemy(
    //     radiusVision: component!.width * 4,
    //     notObserved: _handleNotObserveEnemy,
    //     observed: (enemies) => _handleObserveEnemy(enemies.first),
    //   );
    // }
  }

  void joystickAction(JoystickActionEvent event) {
    if ((event.id == LogicalKeyboardKey.enter.keyId ||
            event.id == LogicalKeyboardKey.space.keyId) &&
        event.event == ActionEvent.DOWN) {
      if ((enableMerge && !finishedMerge) ||
          (enableSecondMerge && !finishedSecondMerge)) {
        component!.position = component!.position.clone() + Vector2(-5, -5);
      }
    }
  }

  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (!lockMove) {
      component?.speed = (gameRef.size.y / 2.2) * event.intensity;
    }
  }
}
