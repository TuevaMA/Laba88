import 'package:flutter/material.dart';
import 'package:laba8/album_d.dart';


void main(){runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
        home: AlbumsScreen());
  }
}

//-------СТРАНИЦА АЛЬБОМОВ-------//
class AlbumsScreen extends StatefulWidget{
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}


class _AlbumsScreenState extends State<AlbumsScreen>{
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String _nameAlbum=' ';
  final nameAlbumController = TextEditingController();

  @override
  void dispose() {
    //final nameAlbumController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Music Player\n        Albums'),
            backgroundColor: Colors.deepOrange
        ),

        body: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const CircleAvatar(backgroundImage: AssetImage('image/night.jpg')),
                        title: const Text('nights'),
                        subtitle: const Text('By Smash'),
                        trailing: const Icon(Icons.audiotrack),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> AlbumDetailScreen(
                                  nameAlbum: _nameAlbum='nights'
                              )));
                        }
                    )
                ),

                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const CircleAvatar(backgroundImage: AssetImage('image/party.jpg')),
                        title: const Text('Hangout'),
                        subtitle: const Text('Party-goer'),
                        trailing: const Icon(Icons.audiotrack),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> AlbumDetailScreen(
                                  nameAlbum: _nameAlbum='Hangout'
                              )));
                        }
                    )
                ),

                Padding(padding: const EdgeInsets.only(top: 15.0,right: 25.0,left: 25.0),
                    child: ListTile(
                        leading: const CircleAvatar(backgroundImage: AssetImage('image/slep.jpg')),
                        title: const Text('nerves'),
                        subtitle: const Text('reassuringly'),
                        trailing: const Icon(Icons.audiotrack),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> AlbumDetailScreen(
                                  nameAlbum: _nameAlbum='nerves'
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