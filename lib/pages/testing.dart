import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomePage(this.cameras);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSuccessful = true;
  CameraController controller;
  VideoPlayerController _videoController;
  int _playBackTime = 0;
  double _volume = 1;

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
        _playBackTime = _videoController.value.position.inSeconds;
        _volume = _videoController.value.volume;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoController.value.initialized
          ? _playerWidget()
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
          setState(() {});
        },
        child: _videoController.value.isPlaying
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow),
      ),
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
              SizedBox(height:40),
              AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Playback'),
              ),
              Slider(
                  value: _playBackTime.toDouble(),
                  max: _videoController.value.duration.inSeconds.toDouble(),
                  min: 0,
                  onChanged: (v) {
                    _videoController.seekTo(Duration(seconds: v.toInt()));
                  }),
                  Text('Volume'),
              Slider(
                  value: _volume,
                  max: 1,
                  min: 0,
                  onChanged: (v) {
                    _videoController.setVolume(v);
                  }),
            ],
          ),
           Positioned(
              bottom: 100,
              right: 1,
                      
                          child: Draggable(
                  child:  Container(
                    
                    margin: orientation == Orientation.portrait ? EdgeInsets.fromLTRB(30, 40, 40, 50):EdgeInsets.fromLTRB(10, 40, 80, 160),
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
             quarterTurns:  orientation == Orientation.portrait ?0:3,
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
      }
    );
  }
}
