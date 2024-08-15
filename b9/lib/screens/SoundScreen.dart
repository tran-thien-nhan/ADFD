import 'package:b9/providers/AudioProvider.dart';
import 'package:b9/widgets/DVDRotate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SoundScreen extends StatelessWidget {
  const SoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Music App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DVDRotate(isRotating: audioProvider.isRotate),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow, size: 40, color: Colors.green),
                    onPressed: () {
                      audioProvider.play("data/SauHongGai.mp3");
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color:
                          audioProvider.isPlaying ? Colors.orange : Colors.blue,
                    ),
                    onPressed: () {
                      audioProvider.togglePlayPause();
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.stop, size: 40, color: Colors.red),
                    onPressed: () {
                      audioProvider.stop();
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      audioProvider.isLooping ? Icons.repeat : Icons.repeat_one,
                      size: 40,
                      color:
                          audioProvider.isLooping ? Colors.orange : Colors.blue,
                    ),
                    onPressed: () {
                      audioProvider.toggleLoop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.replay_10, size: 40, color: Colors.blue),
                    onPressed: () {
                      audioProvider.seekBackward();
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.forward_10, size: 40, color: Colors.blue),
                    onPressed: () {
                      audioProvider.seekForward();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              StreamBuilder<Duration>(
                stream: audioProvider.audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = audioProvider.duration;

                  return Column(
                    children: [
                      Slider(
                        value: position.inSeconds
                            .toDouble()
                            .clamp(0.0, duration.inSeconds.toDouble()),
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          audioProvider
                              .seekMusic(Duration(seconds: value.toInt()));
                        },
                        activeColor: Colors.blueAccent,
                        inactiveColor: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${(position.inMinutes).toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Text("Volume",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Slider(
                value: audioProvider.volume * 100,
                onChanged: (value) {
                  audioProvider.setVolume(value / 100);
                },
                min: 0,
                max: 100,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey,
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(
                  audioProvider.isMuted ? Icons.volume_off : Icons.volume_up,
                  size: 40,
                  color: Colors.blue,
                ),
                onPressed: () {
                  audioProvider.muteUnmute();
                },
              ),
              SizedBox(height: 20),
              Text("Speed",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Slider(
                value: audioProvider.speed,
                onChanged: (value) {
                  audioProvider.setSpeed(value);
                },
                min: 0.5,
                max: 2.0,
                divisions: 6,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey,
                label: "${audioProvider.speed}x",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
