import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/utils/headers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();
  AssetsAudioPlayer player = AssetsAudioPlayer();
  bool isPlaying = false;
  void playAudio() {
    isPlaying = true;
    player.play();
  }

  void pauseAudio() {
    player.pause();
    isPlaying = false;
  }

  void previousAudio() {
    player.previous();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text('Device Music'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text("No Data Found"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  isPlaying == true ? pauseAudio() : playAudio();
                  player.open(
                    Playlist(
                      audios: [
                        Audio.file(item.data![index].uri!),
                      ],
                    ),
                    autoStart: true,
                    showNotification: true,
                  );

                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      playAudio();
                      // log('==============' +
                      //     AppData.appData.allMusic[index].title +
                      //     '=========================');
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          log('==========Reloded==========');
                          log('==========$index===========');
                          return Container(
                            padding: const EdgeInsets.all(20),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xffB5C0D0),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  item.data![index].displayNameWOExt,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(item.data![index].artist ?? 'Unknown'),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (index != 0) {
                                          index--;
                                        }
                                        if (index >= 0) {
                                          setState(() {
                                            player.open(
                                              Audio(item.data![index].uri!),
                                              autoStart: true,
                                              showNotification: true,
                                            );
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Color(0xffCCD3CA),
                                              blurRadius: 3,
                                              offset: Offset(2, 2),
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              blurRadius: 3,
                                              offset: const Offset(-2, -2),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Color(0xffB5C0D0),
                                          child: const Icon(
                                            Icons.skip_previous_rounded,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        log('isPlaying' + isPlaying.toString());
                                        setState(() {
                                          isPlaying = !isPlaying;
                                          isPlaying
                                              ? playAudio()
                                              : pauseAudio();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Color(0xffCCD3CA),
                                              blurRadius: 3,
                                              offset: Offset(2, 2),
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              blurRadius: 3,
                                              offset: const Offset(-2, -2),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color(0xffB5C0D0),
                                          child: Icon(
                                            !isPlaying
                                                ? Icons.play_arrow
                                                : Icons.pause,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        index++;
                                        if (index < item.data!.length) {
                                          setState(() {
                                            // previousAudio();
                                            player.open(
                                              Audio(item.data![index].uri!),
                                              autoStart: true,
                                              showNotification: true,
                                            );
                                            // log('===============${index + 1}=========');
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Color(0xffCCD3CA),
                                              blurRadius: 3,
                                              offset: Offset(2, 2),
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              blurRadius: 3,
                                              offset: const Offset(-2, -2),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Color(0xffB5C0D0),
                                          child: const Icon(
                                            Icons.skip_next_rounded,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                leading: Icon(Icons.music_note_rounded),
                subtitle: Text(item.data![index].artist ?? 'Unknown'),
                title: Text(item.data![index].displayNameWOExt!),
              );
            },
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
