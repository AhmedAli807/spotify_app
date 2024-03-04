import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotify_app/config/background_screen.dart';
import 'package:spotify_app/config/screen_size.dart';

class TrackScreenViewBody extends StatefulWidget {
   TrackScreenViewBody({super.key});

  @override
  State<TrackScreenViewBody> createState() => _TrackScreenViewBodyState();
}

class _TrackScreenViewBodyState extends State<TrackScreenViewBody> {
final player=AudioPlayer();
Duration duration=const Duration();
Duration position=const Duration();
bool isPlaying=false;
String printDuration(Duration duration) {
  String negativeSign = duration.isNegative ? '-' : '';
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
@override
  void initState() {
    super.initState();
    player.onPlayerComplete.listen((_) {
      setState(() {
        position=duration;
      });
      
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration=newDuration;
      });
    });
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position=newPosition;
      });
    });
  }
   @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: BackGroundScreen(
              firstColor: Colors.grey,
              secondColor: Colors.black,
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.expand_more,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Text(
                      'PLaying From Artist',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Amir Eid',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.08,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/amir eid.jpeg')),
            SizedBox(
              height: ScreenSize.height(context) * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Metkatef',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      'Amir Eid',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.03,
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  overlayShape: SliderComponentShape.noOverlay,
                  trackHeight: 1,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0)),
              child: Container(
                width: ScreenSize.width(context),
                child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: Colors.white,
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        player.seek(Duration(seconds: value.toInt()));
                      });
                    }),
              ),
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${printDuration((duration-position))}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '${printDuration(duration)}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.shuffle,
                  color: Colors.green,
                  size: 30,
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      player.seek(Duration(seconds:position.inSeconds-10));
                    });
                  },
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isPlaying=!isPlaying;

                    });
                    if(isPlaying){
                      player.play(AssetSource('Albumaty.Com_amyr_ayd_mtktf.mp3'));
                    }
                    else{
                      player.pause();
                    }
                  },
                  icon: Icon(
                 isPlaying?   Icons.pause_circle_outline:Icons.play_circle_fill,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    player.seek(Duration(seconds:position.inSeconds+10));

                  },
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Icon(
                  Icons.minimize,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            )
          ])),
    );
  }
}
