import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  double _volume = 1.0;
  bool _isRotate = false;
  bool _isLooping = false;
  bool _isShuffled = false;
  double _speed = 1.0;
  bool _isMuted = false;

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  bool get isPlaying => _isPlaying;
  double get volume => _volume;
  bool get isRotate => _isRotate;
  bool get isLooping => _isLooping;
  bool get isShuffled => _isShuffled;
  double get speed => _speed;
  bool get isMuted => _isMuted;

  AudioProvider() {
    _audioPlayer.positionStream.listen((position) {
      _position = position;
      if (_position >= _duration) {
        _stopRotation();
      }
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _position = Duration.zero;
        _stopRotation();
        notifyListeners();
      }
    });
  }

  Future<void> play(String url) async {
    try {
      await _audioPlayer.setAsset(url);
      _audioPlayer.play();
      _isPlaying = true;
      _isRotate = true;
      notifyListeners();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      _isRotate = false;
    } else {
      _audioPlayer.play();
      _isRotate = true;
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    _position = Duration.zero; // Reset position to the start
    _isPlaying = false;
    _isRotate = false;
    notifyListeners();
  }

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
    _volume = volume;
    notifyListeners();
  }

  void muteUnmute() {
    if (_isMuted) {
      _audioPlayer.setVolume(_volume);
    } else {
      _audioPlayer.setVolume(0.0);
    }
    _isMuted = !_isMuted;
    notifyListeners();
  }

  void seekMusic(Duration position) {
    if (position < _duration) {
      _audioPlayer.seek(position);
    }
    notifyListeners();
  }

  void toggleLoop() {
    _isLooping = !_isLooping;
    notifyListeners();
  }

  void shuffle(List<String> tracks) {
    if (_isShuffled) {
      _audioPlayer.setShuffleModeEnabled(false);
      _isShuffled = false;
    } else {
      _audioPlayer.setShuffleModeEnabled(true);
      _audioPlayer.setAudioSource(ConcatenatingAudioSource(
          children: tracks
              .map((track) => AudioSource.uri(Uri.parse(track)))
              .toList()));
      _isShuffled = true;
    }
    notifyListeners();
  }

  void setSpeed(double speed) {
    _audioPlayer.setSpeed(speed);
    _speed = speed;
    notifyListeners();
  }

  void seekForward() {
    Duration newPosition = _position + Duration(seconds: 10);
    if (newPosition < _duration) {
      _audioPlayer.seek(newPosition);
    } else {
      _audioPlayer.seek(_duration);
    }
    notifyListeners();
  }

  void seekBackward() {
    Duration newPosition = _position - Duration(seconds: 10);
    if (newPosition >= Duration.zero) {
      _audioPlayer.seek(newPosition);
    } else {
      _audioPlayer.seek(Duration.zero);
    }
    notifyListeners();
  }

  void _stopRotation() {
    _isRotate = false;
    _isPlaying = false;
    _audioPlayer.stop();
  }
}
