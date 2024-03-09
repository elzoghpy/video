// ignore_for_file: avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_send/screens/play_record.dart';
import 'package:firebase_send/screens/vidio_player.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class RecordAudio extends StatefulWidget {
  const RecordAudio({super.key});

  @override
  State<RecordAudio> createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = '';
  final player = AudioPlayer();

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VideoPlayer()));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      child: const Row(
                        children: [
                          Text(
                            'Video Player',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.video_library_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PlayRecord()));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      child: const Row(
                        children: [
                          Text(
                            'Audio Player',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.audiotrack_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isRecording)
                    const Padding(
                      padding: EdgeInsets.only(right: 60, left: 46),
                      child: Text(
                        'Recording...',
                        style:
                            TextStyle(fontSize: 20, color: Colors.deepOrange),
                      ),
                    ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      onPressed: isRecording ? stopRecording : startRecording,
                      child: isRecording
                          ? const Text(
                              'Stop Recording',
                              style: TextStyle(color: Colors.white),
                            )
                          : const Text(
                              'Start Recording',
                              style: TextStyle(color: Colors.white),
                            )),
                  const SizedBox(
                    width: 50,
                  ),
                  if (!isRecording)
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.deepOrange),
                        onPressed: playRecording,
                        child: const Text(
                          'Play Recording',
                          style: TextStyle(color: Colors.white),
                        )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stopping Recording : $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
      print('ok');
    } catch (e) {
      print('Error Playing Recording : $e');
    }
  }
}
