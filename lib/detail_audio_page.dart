import 'package:audio_player/utils/app_colors.dart';
import 'package:audio_player/utils/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DetailAudioPage extends StatefulWidget {
  final songsData;

  final int index;
  const DetailAudioPage({Key? key,this.songsData,required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  bool playing=false;
  late AudioPlayer advancedPlayer;
  @override
  void initState(){
    super.initState();
    advancedPlayer=AudioPlayer();
  }



  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              height:screenHeight/3,
              child: Container(
                color: AppColors.audioBlueBackground,
              )),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                 if(playing==false){
                   advancedPlayer.stop();
                 }
                  Navigator.of(context).pop();

                },
                  icon: Icon(Icons.arrow_back_ios)),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search))
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            left: 0,
              right: 0,
              top: screenHeight*0.2,
              height: screenHeight*0.4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.1,),
                    Text(this.widget.songsData[this.widget.index]['title'],style: TextStyle(fontSize: 30,fontFamily: 'Oswald'),),
                    Text(this.widget.songsData[this.widget.index]['text'],style: TextStyle(fontSize: 20,fontFamily: 'Oswald',color: AppColors.subTitleText),),
                    AudioFile(advancedPlayer:AudioPlayer(),audioPath:this.widget.songsData[this.widget.index]['audio']),

                  ],
                ),
              )),
          Positioned(
            top: screenHeight*0.12,
              left: (screenWidth-150)/2,
              right: (screenWidth-150)/2,
              height: screenHeight*0.18,

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.audioGreyBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 5),
                      image: DecorationImage(
                        image: AssetImage(this.widget.songsData[this.widget.index]['img']),
                        fit: BoxFit.fill
                      )
                    ),
                  ),

                ),

              ))
        ],
      ),
    );
  }
}
