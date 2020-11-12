import 'package:assignment/pages/video_player.dart';
import 'package:assignment/pages/youtubeVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import "package:google_fonts/google_fonts.dart";
import 'chewie.dart';


class FirstPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  FirstPage(this.cameras);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[800],
      body: OrientationBuilder(builder: (context, orientation) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 3),
                child: Text(
                  "Yellow Class",
                  style:
                      GoogleFonts.montserrat(fontSize: 22, color: Colors.white),
                ),
              ),
              Text(
                "Flutter Assignment",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 40, 45, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoHomePage(widget.cameras)),
                    );
                  },
                  child: Center(
                      child: Container(
                    child: Text('Using only Video Player Package'),
                  )),
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(45, 15, 45, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChewieHomePage(widget.cameras)),
                    );
                  },
                  child: Center(
                      child: Container(
                    child: Text('Using Chewie + Video Player Package'),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 15, 45, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YoutubeVideoPlayer(widget.cameras)),
                    );
                  },
                  child: Center(
                      child: Container(
                    child: Text('Using Youtube Player Flutter Package'),
                  )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
