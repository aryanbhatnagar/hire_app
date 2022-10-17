import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  //const VideoPlayerApp({super.key});

  var URL;
  VideoPlayerApp(this.URL);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(URL),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  //const VideoPlayerScreen({Key? key}) : super(key: key);
  var URL;


  VideoPlayerScreen(this.URL);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(URL);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  var URL;

  _VideoPlayerScreenState(this.URL);

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network("${URL}");
    _controller.addListener(() {
      setState(() {
      });
    });
    _controller.setLooping(true);
    _controller.setVolume(1);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                    aspectRatio: 16/9,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[

                        VideoPlayer(_controller),
                        VideoProgressIndicator(_controller, allowScrubbing: true),
                      ],
                    )
                )
                    :Container(
                  child: Center(child: CircularProgressIndicator(color: Colors.teal,),),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
      ),
    );

  }
}