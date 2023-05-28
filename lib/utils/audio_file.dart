import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  AudioFile({Key? key,required this.advancedPlayer,required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration=new Duration();
  Duration _position=new Duration();
  //final String path="https://cdn.pagalworld.us/songs/320kbps/Raees%202017%20-%20Saanson%20Ke.mp3";
  bool isPlaying=false;
  bool isPaused=false;
  bool isRepeat=false;
  Color color=Colors.black;
  List<IconData> _icons=[
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];
  @override
  void initState() {
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen(( d){
      setState(() {
        _duration=d;
      });
    });
    this.widget.advancedPlayer.onPositionChanged.listen(( p){
      setState(() {
        _position=p;
      });
    });
    this.widget.advancedPlayer.setSourceUrl(this.widget.audioPath);
    this.widget.advancedPlayer.onPlayerComplete.listen((event) {
     setState(() {
       _position=Duration(seconds: 0);
       if(isRepeat==true){
         isPlaying=true;
       }else{
         isPlaying=false;
         isRepeat=false;
       }
     });
    });
  }
  Widget btnLoop(){
    return IconButton(
        onPressed: (){
        },
        icon: Icon(Icons.queue_music,size: 30,));
  }
  Widget btnFast(){
    return IconButton(
        onPressed: (){
          this.widget.advancedPlayer.setPlaybackRate(1.5);
        },
        icon: Icon(Icons.fast_forward_sharp,size: 30,));
  }
  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/image/repeat.png'),
        size: 20,
        color: color,
      ),
      onPressed: (){
        if(isRepeat==false){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });
        }else if(isRepeat==true){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            color=Colors.black;
            isRepeat=false;
          });
        }
      },
    );


  }
  Widget btnSlow(){
    return IconButton(
        onPressed: (){
          this.widget.advancedPlayer.setPlaybackRate(0.5);

        },
        icon: Icon(Icons.fast_rewind_sharp,size: 30,));
  }
  Widget btnStart(){
    return IconButton(
        onPressed: (){
          if(isPlaying==false){
            this.widget.advancedPlayer.play(UrlSource(this.widget.audioPath));
            this.widget.advancedPlayer.setPlaybackRate(1.0);
            setState(() {
              isPlaying=true;
            });
          }else if(isPlaying==true){
            this.widget.advancedPlayer.pause();
            setState(() {
              isPlaying=false;
            });
          }

        },
        icon:isPlaying==false?Icon(_icons[0],size: 50,color: Colors.blue,) :Icon(_icons[1],size: 50,color: Colors.blue,)
    );
  }
  Widget slider(){
    return Slider(
      activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value:_position.inSeconds.toDouble() ,
        min:0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged:(double value){
        setState(() {
          changeToSecond(value.toInt());
          value=value;

        });
        }
    );
  }
  void changeToSecond(int second){
    Duration newDuration=Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);

  }
  Widget lodeAsset(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop()
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(_position.toString().split('.')[0],style: TextStyle(fontSize: 16),),
                Text(_duration.toString().split('.')[0],style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
          slider(),
          lodeAsset()
        ],
      ),
    );
  }
}