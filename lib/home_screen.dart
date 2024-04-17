import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer player;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/songs/sample.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2234AE),
                Color(0xFF191714),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.black,
              height: 200,
              width: 300,
            ),
            const SizedBox(
              height: 240,
            ),
            StreamBuilder<PositionData>(
              stream: positionDataStream,
              builder: (context, snapshot) {
                final postionData = snapshot.data;
                return ProgressBar(
                  baseBarColor: Colors.white,
                  thumbColor: Colors.white,
                  progressBarColor: Colors.yellow,
                  timeLabelTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  progress: postionData?.position ?? Duration.zero,
                  buffered: postionData?.bufferedPosition ?? Duration.zero,
                  total: postionData?.duration ?? Duration.zero,
                  onSeek: player.seek,
                );
              },
            ),
            Controls(audioPlayer: player),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 80,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: audioPlayer.play,
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 80,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next,
                    size: 80,
                    color: Colors.white,
                  )),
            ],
          );
        } else if (processingState != ProcessingState.completed) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 80,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: audioPlayer.pause,
                  icon: const Icon(
                    Icons.pause,
                    size: 80,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next,
                    size: 80,
                    color: Colors.white,
                  )),
            ],
          );
        }
        return const Icon(
          Icons.play_arrow,
          size: 80,
          color: Colors.white,
        );
      },
    );
  }
}
