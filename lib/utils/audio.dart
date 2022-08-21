import 'dart:async';
import 'package:flame_audio/flame_audio.dart';

class GameAudio {
  static Future initialize() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      'sfx/button_click.ogg',
      'bgm/theme.mp3',
      'bgm/menu.mp3',
    ]);
  }

  static void buttonClick() {
    FlameAudio.play('sfx/button_click.ogg', volume: 0.6);
  }

  static void stopBgm() async {
    await FlameAudio.bgm.stop();
  }

  static void playTheme() async {
    FlameAudio.bgm.play('bgm/theme.mp3');
  }

  static void menu() async {
    FlameAudio.bgm.play('bgm/menu.mp3');
  }

  static void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  static void resumeBgm() {
    FlameAudio.bgm.resume();
  }
}
