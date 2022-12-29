import 'package:flutter/material.dart';
import 'package:laba8/trackone.dart';
import 'package:laba8/tracktwo.dart';
import 'package:laba8/tracktree.dart';

//import 'albums_screen.dart';

//-------СПИСОК ТРЕКОВ АЛЬБОМА-------//
class AlbumDetailScreen extends StatelessWidget{
  AlbumDetailScreen(
      {super.key,
        required this.nameAlbum
      });

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final String? nameAlbum;
  String _nameMusic='';
  String _nameAuthor='';

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Album "$nameAlbum"'),
            backgroundColor: Colors.pink
        ),

        body: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const Icon(Icons.queue_music),
                        title: const Text('2 lights'),
                        subtitle: const Text('By Smash'),
                        trailing: const Icon(Icons.play_arrow),
                        onTap: () {
                          // var player;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> TrackOneScreen(
                                  nameMusic: _nameMusic='2 lights',
                                  nameAuthor: _nameAuthor='By Smash',
                                  audioPlayerManager: AudioPlayerManagerOne()
                              )));
                        }
                    )
                ),

                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const Icon(Icons.queue_music),
                        title: const Text('fights'),
                        subtitle: const Text('Party-goer'),
                        trailing: const Icon(Icons.play_arrow),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> TrackTwoScreen(
                                  nameMusic: _nameMusic='fights',
                                  nameAuthor: _nameAuthor='Party-goer',
                                  audioPlayerManager: AudioPlayerManagerTwo()
                              )));
                        }
                    )
                ),

                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const Icon(Icons.queue_music),
                        title: const Text('sonny'),
                        subtitle: const Text('reassuringly'),
                        trailing: const Icon(Icons.play_arrow),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> TrackThreeScreen(
                                  nameMusic: _nameMusic='sonny',
                                  nameAuthor: _nameAuthor='reassuringly',
                                  audioPlayerManager: AudioPlayerManagerThree()
                              )));
                        }
                    )
                ),
              ],
            )
        )
    );
  }
}