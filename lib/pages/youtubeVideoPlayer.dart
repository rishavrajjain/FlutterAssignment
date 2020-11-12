import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'videoClass.dart';
import 'package:camera/camera.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final List<CameraDescription> cameras;
  YoutubeVideoPlayer(this.cameras);
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.yellow[800],

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 70, 10, 0),
            child: Text("Youtube Feed",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: ListView(
                children: <Widget>[
                  VideoClass(
                    videoURL: 'https://www.youtube.com/watch?v=70LNd-ZqLoIA',
                    title: 'DIY(Do it Yourself) Activity For Kids - Diya Hanging (Diwali Special) ',
                  ),
                  
                  
                   
                    SizedBox(height: 18),
                   VideoClass(
                    videoURL:
                        'https://www.youtube.com/watch?v=gnhscqUJnKc',
                    title: 'Drawing Class for kids | Card making | Diwali Special',
                  ),
                  SizedBox(height: 18),
                  VideoClass(
                    videoURL:
                        'https://www.youtube.com/watch?v=i_mVmMKMkjwI',
                    title: '3D Art For Kids | Mickey Mouse (Kids Activity)',
                  ),
                  
                  
                ],
              ),
            ),
          ),
          SizedBox(height: 14)
        ],
      ),
    );
  }
}
