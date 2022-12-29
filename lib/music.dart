import 'package:flutter/material.dart';
//-------ПРОИГРЫВАНИЕ ПЕСНИ-------//
class MusicScreen extends StatelessWidget{
  MusicScreen(
      {super.key,
        required this.nameMusic,
        this.nameAuthor,
      });

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final String? nameMusic;
  final String? nameAuthor;

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Music Player'),
            backgroundColor: Colors.deepOrange
        ),

        body: Form(
            key: _form,
            child:Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 35.0),
                  child: SizedBox(width: 200,height: 200,
                      child: Image.network('https://e-cdn-images.dzcdn.net/images/cover/8b6cf17c815d0170272c32c9a80e8900/264x264-000000-80-0-0.jpg')
                  )
              ),

              Align(alignment: Alignment.center,
                  child:Padding(padding: const EdgeInsets.only(top: 35.0),
                      child: Text('$nameMusic', style: const TextStyle(fontSize: 20.0))
                  )
              ),

              Align(alignment: Alignment.center,
                  child: Padding(padding: const EdgeInsets.only(top: 10.0),
                      child: Text('$nameAuthor', style:const TextStyle(fontSize: 18.0))
                  )
              ),

              Align(alignment: Alignment.center,
                  child: Padding(padding: const EdgeInsets.only(top: 35.0,left: 35.0, right: 35.0),
                      child: Slider(
                          value: double.parse(currentpos.toString()),
                          min: 0,
                          max: double.parse(maxduration.toString()),
                          divisions: maxduration,
                          label: currentpostlabel,
                          onChanged: (double value) async {
                            int seekval = value.round();
                          },
                          activeColor: Colors.deepOrange,
                          inactiveColor: Colors.deepOrange.shade100
                      )
                  )
              ),

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 15.0, left: 400),
                  child: Row(children: <Widget>[
                    ElevatedButton.icon(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),
                        icon: const Icon(Icons.pause),
                        label: const Text('Pause',style: TextStyle(fontSize: 20))),
                    const SizedBox(width: 20, height: 20,),
                    ElevatedButton.icon(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play',style: TextStyle(fontSize: 20)))
                  ])
              )
            ])
        )
    );
  }
}