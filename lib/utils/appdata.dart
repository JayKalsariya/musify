import 'package:music_app/utils/headers.dart';

import '../modals/music_modal.dart';

class AppData {
  AppData._() {
    allMusic = musics.map((e) => Music.fromMap(e)).toList();
  }

  static AppData appData = AppData._();

  List<Map<String, dynamic>> musics = [
    {
      "title": "Apna Bana Le",
      "artist": "Arijit Singh",
      "url": "assets/musics/apna bana le.mp3",
      "image":
          "https://m.media-amazon.com/images/I/5156BciMr3L._UXNaN_FMjpg_QL85_.jpg",
    },
    {
      "title": "Kesariya",
      "artist": "Arijit Singh",
      "url": "assets/musics/kesariya.mp3",
      "image":
          "https://i.pinimg.com/564x/e3/ea/63/e3ea63c19dc88c6c881b646b0f32c15c.jpg",
    },
    {
      "title": "Lag Ja Gale",
      "artist": "Sanam",
      "url": "assets/musics/lag ja.mp3",
      "image":
          "https://i.pinimg.com/564x/b0/3a/61/b03a6144bedc3b0d7ea220bd8b9aa514.jpg",
    },
    {
      "title": "Tu Mann Meri",
      "artist": "King",
      "url": "assets/musics/mann meri.mp3",
      "image":
          "https://i1.sndcdn.com/artworks-NdUXtLgMczD8EAQ4-qTyQBA-t500x500.jpg",
    },
    {
      "title": "Saudebazi",
      "artist": "Arijit Singh",
      "url": "assets/musics/saudebazi.mp3",
      "image":
          "https://is3-ssl.mzstatic.com/image/thumb/Music116/v4/ad/2f/1a/ad2f1acd-9a1b-56b1-0847-c9fd51ce95b2/3701624054840_cover.jpg/1200x1200bb.png",
    }
  ];

  List<Music> allMusic = [];
}
