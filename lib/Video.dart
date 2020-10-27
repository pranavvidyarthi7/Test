import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final boxSizeV, boxSizeH;
  Video({this.boxSizeH, this.boxSizeV});
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Video> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    // _controller = VideoPlayerController.asset('assets/Butterfly-209.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          _controller.play();
          return ClipRRect(
            borderRadius: BorderRadius.circular(3 * widget.boxSizeV),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3 * widget.boxSizeV),
              ),
              height: 54 * widget.boxSizeV,
              width: 85 * widget.boxSizeH,
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return ClipRRect(
            borderRadius: BorderRadius.circular(3 * widget.boxSizeV),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(3 * widget.boxSizeV),
                ),
                child: Center(child: CircularProgressIndicator())),
          );
        }
      },
    );
  }
}
