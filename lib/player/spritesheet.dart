import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static const double stepTime = 1.0;
  static Vector2 textureSize = Vector2(35, 35);

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        'sprite.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        'sprite.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        'sprite.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        'sprite.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleLeft: idleLeft,
        idleDownLeft: idleLeft,
        idleUpLeft: idleLeft,
        runLeft: runLeft,
        runUpLeft: runLeft,
        runDownLeft: runLeft,
        idleRight: idleRight,
        idleDownRight: idleRight,
        idleUpRight: idleRight,
        runRight: runRight,
        runUpRight: runRight,
        runDownRight: runRight,
      );
}

class PlayerSpriteSheetTwo {
  static const double stepTime = 1.0;
  static Vector2 textureSize = Vector2(35, 35);

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        'sprite_two.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        'sprite_two.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        'sprite_two.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        'sprite_two.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: textureSize,
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleLeft: idleLeft,
        idleDownLeft: idleLeft,
        idleUpLeft: idleLeft,
        runLeft: runLeft,
        runUpLeft: runLeft,
        runDownLeft: runLeft,
        idleRight: idleRight,
        idleDownRight: idleRight,
        idleUpRight: idleRight,
        runRight: runRight,
        runUpRight: runRight,
        runDownRight: runRight,
      );
}
