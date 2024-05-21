import 'dart:developer';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:music_app/utils/appdata.dart';
import 'package:music_app/utils/headers.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backgroundColor: Colors.transparent,
        title: const Text('Music'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.storage);
              setState(() {});
            },
            icon: const Icon(Icons.drive_file_move_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: AppData.appData.allMusic.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    isPlaying == true ? pauseAudio() : playAudio();
                    player.open(
                      Playlist(
                        audios: [
                          Audio(AppData.appData.allMusic[index].url),
                        ],
                      ),
                      autoStart: true,
                      showNotification: true,
                    );

                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        playAudio();
                        log('==============${AppData.appData.allMusic[index].title}=========================');
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            log('==========Reloded==========');
                            log('==========$index===========');
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: 580,
                              decoration: BoxDecoration(
                                color: const Color(0xffB5C0D0),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          AppData.appData.allMusic[index].image,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    AppData.appData.allMusic[index].title,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    AppData.appData.allMusic[index].artist,
                                    style: const TextStyle(fontSize: 18),
                                  ),
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
                                                Audio(AppData.appData
                                                    .allMusic[index].url),
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
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                blurRadius: 3,
                                                offset: const Offset(-2, -2),
                                              ),
                                            ],
                                          ),
                                          child: const CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Color(0xffB5C0D0),
                                            child: Icon(
                                              Icons.skip_previous_rounded,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          log('isPlaying$isPlaying');
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
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                blurRadius: 3,
                                                offset: const Offset(-2, -2),
                                              ),
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                const Color(0xffB5C0D0),
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
                                          if (index <
                                              AppData.appData.allMusic.length) {
                                            setState(() {
                                              // previousAudio();
                                              player.open(
                                                Audio(AppData.appData
                                                    .allMusic[index].url),
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
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                blurRadius: 3,
                                                offset: const Offset(-2, -2),
                                              ),
                                            ],
                                          ),
                                          child: const CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Color(0xffB5C0D0),
                                            child: Icon(
                                              Icons.skip_next_rounded,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      print("============");
                                      print("TAPPED....");
                                      print("============");
                                      Directory? directory;
                                      try {
                                        if (Platform.isIOS) {
                                          print("======");
                                          print("-iOS-");
                                          print("======");
                                          directory =
                                              await getApplicationDocumentsDirectory();
                                        } else {
                                          print("========================");
                                          print("I'M ANDROID...");
                                          print("========================");
                                          print(":) Getting path...");
                                          directory = Directory(
                                              '/storage/emulated/0/Download');
                                          print("We got the path...");
                                          // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
                                          // ignore: avoid_slow_async_io
                                          if (!await directory.exists()) {
                                            print("Not exists...");
                                            directory =
                                                await getExternalStorageDirectory();
                                          } else {
                                            print("It exists........");
                                          }
                                        }
                                      } catch (err, stack) {
                                        print(
                                            "Cannot get download folder path");
                                      }

                                      final downloadPath = directory!.path;

                                      print(
                                          "===========================================");
                                      print("DWN PATH: $downloadPath");
                                      print(
                                          "===========================================");
                                      File audioFile = File(
                                          AppData.appData.allMusic[index].url);

                                      File dwnFile = await File(
                                              '$downloadPath/${AppData.appData.allMusic[index].title}-${DateTime.now().millisecondsSinceEpoch}.mp3')
                                          .create();

                                      var byteData = rootBundle.load(
                                          AppData.appData.allMusic[index].url);
                                      await byteData.then(
                                        (value) => dwnFile.writeAsBytesSync(
                                          value.buffer.asUint8List(),
                                        ),
                                      );

                                      print(
                                          "FILE CREATED>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

                                      // dwnFile.writeAsBytesSync(
                                      //     audioFile.readAsBytesSync());

                                      // print(
                                      //     "===========================================");
                                      // print("File Created at: $dwnFile");
                                      // print(
                                      //     "===========================================");

                                      //     .then((value) {
                                      //   print(
                                      //       "===========================================");
                                      //   print("FILE DOWNLOADED..............");
                                      //   print(
                                      //       "===========================================");
                                      // }).onError((error, stackTrace) {
                                      //   print(
                                      //       "===========================================");
                                      //   print(
                                      //       "FAILLED TO DOWNLOADED..............");
                                      //   print("ERROR: $error");
                                      //   print(
                                      //       "===========================================");
                                      // });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffB5C0D0),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          ]),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Download",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          AppData.appData.allMusic[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Text(
      //     AppData.appData.allMusic[0].title,
      //   ),
      // ),
    );
  }
}
