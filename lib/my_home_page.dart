import 'dart:convert';

import 'package:audio_player/detail_audio_page.dart';
import 'package:audio_player/utils/app_colors.dart';
import 'package:audio_player/utils/my_tabs.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget  {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List popularSongs=[];
  List songs=[];
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async{
    await DefaultAssetBundle.of(context).loadString('json/popular_songs.json').then((s){
      setState(() {
        popularSongs=json.decode(s);

      });
    });
    await DefaultAssetBundle.of(context).loadString('json/songs.json').then((s){
      setState(() {
        songs=json.decode(s);

      });
    });
  }
  @override
  void initState() {
    super.initState();
    _scrollController=ScrollController();
    _tabController=TabController(length: 3, vsync: this);
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       color:AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body:Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10,left:10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage('assets/image/menu.png',),size: 24,color:Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications)

                      ],
                    )
                  ],

                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text('The most popular songs of SRK',style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top:0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.85),
                            itemCount: popularSongs==null?0:popularSongs.length,
                            itemBuilder: (_,i){
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin:const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(popularSongs[i]['img']),
                                      fit: BoxFit.cover
                                    )
                                ),
                              );
                            }),

                      )
                      ,
                    )
                  ],
                ),
              ),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext contex,bool isScroll){
                  return[
                    SliverAppBar(
                      backgroundColor: AppColors.sliverBackground,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20,left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            labelPadding: const EdgeInsets.only(right: 10),
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: Offset(0,0)
                                )
                              ]
                            ),
                            tabs: [
                              AppTabs(color: AppColors.menu1Color, text: 'New'),
                              AppTabs(color: AppColors.menu2Color, text: 'Popular'),
                              AppTabs(color: AppColors.menu3Color, text: 'Trending')
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: songs==null?0:songs.length,
                        itemBuilder: (_,i){
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAudioPage(songsData:songs,index: i,),));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.tabVarViewColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: Offset(0,3),
                                  ),
                                ]
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(songs[i]['img']),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(songs[i]['title'],style: TextStyle(fontSize: 20,fontFamily: 'Oswald',),),
                                      Text(songs[i]['text'],style: TextStyle(fontSize: 16,fontFamily: 'Oswald',color: AppColors.subTitleText),),



                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        )
                    ),
                    const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        )
                    ),

                  ],
                ),
              ))


            ],
          )
        ),
      ),

    );
  }
}
