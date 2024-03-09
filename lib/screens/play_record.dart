// ignore_for_file: avoid_unnecessary_containers

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayRecord extends StatefulWidget {
  const PlayRecord({super.key});

  @override
  State<PlayRecord> createState() => _PlayRecordState();
}

class _PlayRecordState extends State<PlayRecord> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((nwePosition) {
      setState(() {
        position = nwePosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(-15),
                        onPressed: () {
                          if (isPlaying) {
                            player.pause();
                          } else {
                            audioPlayer();
                          }
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 34,
                          color: isPlaying ? Colors.grey : Colors.blue,
                        )),
                    IconButton(
                        padding: const EdgeInsets.all(-15),
                        onPressed: () {
                          player.stop();
                        },
                        icon: const Icon(
                          Icons.stop,
                          size: 32,
                          color: Colors.red,
                        )),
                    SizedBox(
                      width: 295,
                      child: Slider(
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (value) {
                            final position = Duration(seconds: value.toInt());
                            player.seek(position);
                            player.resume();
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 55,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(formatTime(position.inSeconds)),
                          const SizedBox(
                            width: 150,
                          ),
                          Text(formatTime((duration - position).inSeconds))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> audioPlayer() async {
    String audioPath = "audios/rad.mp3";
    await player.play(AssetSource(audioPath));
  }
}
