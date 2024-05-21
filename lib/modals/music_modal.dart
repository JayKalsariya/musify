class Music {
  final String title;
  final String artist;
  final String url;
  final String image;

  Music({
    required this.title,
    required this.artist,
    required this.url,
    required this.image,
  });

  factory Music.fromMap(Map<String, dynamic> data) {
    return Music(
      title: data['title'],
      artist: data['artist'],
      url: data['url'],
      image: data['image'],
    );
  }

  Map<String, dynamic> get toMap => {
        'title': title,
        'artist': artist,
        'url': url,
        'image': image,
      };
}
