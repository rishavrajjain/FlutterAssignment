import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';

class ChewieHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  ChewieHomePage(this.cameras);

  @override
  _ChewieHomePageState createState() => _ChewieHomePageState();
}

class _ChewieHomePageState extends State<ChewieHomePage> {
  bool isSuccessful = true;
  CameraController controller;
  VideoPlayerController _videoController;
  double _volume = 1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[1], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    _videoController = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/360/big_buck_bunny_360p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
      
    _videoController.addListener(() {
      setState(() {
        
        _volume = _videoController.value.volume;
      });
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
     
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    _videoController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoController.value.initialized
          ? _playerWidget()
          : Center(child: CircularProgressIndicator()),
     
    );
  }

  Widget _playerWidget() {
    return OrientationBuilder(builder: (context, orientation) {
      return (
        SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 40),
              Chewie(
        controller: _chewieController,
      ),
              
              
              
            ],
          ),
          
              Positioned(
                 bottom: 50,
                 left:30,
                              child: Row(
                                children: <Widget>[ Text('Volume:'),Slider(
                    value: _volume,
                    max: 1,
                    min: 0,
                    onChanged: (v) {
                      _videoController.setVolume(v);
                    }),]
                              ),
              ),
          Positioned(
            bottom: 100,
            right: 1,
            child: Draggable(
              child: Container(
                margin: orientation == Orientation.portrait
                    ? EdgeInsets.fromLTRB(30, 40, 40, 50)
                    : EdgeInsets.fromLTRB(10, 40, 80, 160),
                // alignment: Alignment.bottomRight,
                height: 90,
                width: 70,

                //     child:
                //      ClipRRect(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50.0),
                //   topRight: Radius.circular(50.0),
                //   bottomRight: Radius.circular(50.0),
                //   bottomLeft: Radius.circular(50.0),

                // ),
                child: RotatedBox(
                  quarterTurns: orientation == Orientation.portrait ? 0 : 3,
                  child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: CameraPreview(controller)),
                ),
                // ),
              ),
              feedback: Container(
                alignment: Alignment.bottomRight,
                height: 90,
                width: 70,

                //     child:
                //      ClipRRect(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50.0),
                //   topRight: Radius.circular(50.0),
                //   bottomRight: Radius.circular(50.0),
                //   bottomLeft: Radius.circular(50.0),

                // ),
                child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller)),
                // ),
              ),
              childWhenDragging: Container(),
            ),
          ),
        ]),
      ));
    });
  }
}
