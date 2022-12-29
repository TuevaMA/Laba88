import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:laba8/audio_p_b.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,),
      home: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late AudioPlayerManagerThree manager;

  @override
  void initState() {
    super.initState();
    manager = AudioPlayerManagerThree();
    manager.init();
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrackThreeScreen(audioPlayerManager: manager);
  }
}

class TrackThreeScreen extends StatefulWidget {
  const TrackThreeScreen({
    Key? key,
    required this.audioPlayerManager,
    this.nameMusic,
    this.nameAuthor,
  }) : super(key: key);

  final AudioPlayerManagerThree audioPlayerManager;
  final String? nameMusic;
  final String? nameAuthor;

  @override
  State<TrackThreeScreen> createState() => _TrackThreeScreenState(namemusic: nameMusic, nameauthor: nameAuthor);
}

class _TrackThreeScreenState extends State<TrackThreeScreen> {
  _TrackThreeScreenState({this.namemusic,
    this.nameauthor,
  });
  final String? namemusic;
  final String? nameauthor;
  var _labelLocation = TimeLabelLocation.below;
  var _labelType = TimeLabelType.remainingTime;
  var _labelPadding = 0.0;
  var _barHeight = 10.0;
  var _barCapShape = BarCapShape.round;
  var _thumbCanPaintOutsideBar = true;
  var _thumbRadius = 10.0;

  @override
  void initState() {
    super.initState();
    widget.audioPlayerManager.init();
  }

  @override
  void dispose() {
    widget.audioPlayerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Music Player'),
          backgroundColor: Colors.deepOrange
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 7.0),
                  child: SizedBox(width: 520,height: 320,
                      child: Image.asset('audio/sonny.png', fit: BoxFit.fill,)
                  )
              ),
              Align(alignment: Alignment.center,
                  child:Padding(padding: const EdgeInsets.only(top: 15.0),
                      child: Text('$namemusic', style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold))
                  )
              ),
              Align(alignment: Alignment.center,
                  child: Padding(padding: const EdgeInsets.only(top: 5.0),
                      child: Text('$nameauthor', style:const TextStyle(fontSize: 18.0))
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  child:_progressBar()
              ),
              const SizedBox(height: 20),
              _playButton(),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: widget.audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: widget.audioPlayerManager.player.seek,
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          baseBarColor: Colors.deepOrange[100],
          progressBarColor: Colors.deepOrange,
          bufferedBarColor: Colors.deepOrange[200],
          barHeight: _barHeight,
          thumbColor: Colors.deepOrange,
          barCapShape: _barCapShape,
          thumbRadius: _thumbRadius,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: widget.audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            color: Colors.deepOrange,
            iconSize: 32.0,
            onPressed: widget.audioPlayerManager.player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            color: Colors.deepOrange,
            iconSize: 32.0,
            onPressed: widget.audioPlayerManager.player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            color: Colors.deepOrange,
            iconSize: 32.0,
            onPressed: () =>
                widget.audioPlayerManager.player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class AudioPlayerManagerThree {
  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
            (position, playbackEvent) => DurationState(
          progress: position,
          buffered: playbackEvent.bufferedPosition,
          total: playbackEvent.duration,
        ));
    player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3');
  }

  void dispose() {
    player.dispose();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}