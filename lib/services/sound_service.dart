import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService instance = SoundService._();

  SoundService._();

  final AudioPlayer _sfxPlayer = AudioPlayer();

  Future<void> playCardDeal() async {
    await _sfxPlayer.stop();

    await _sfxPlayer.play(
      AssetSource('sounds/card_deal.wav'),
    );
  }
}