
class Movie {
  int id;
  num vote_average;
  String title;
  String original_language;
  String poster_path;
  String release_date;
  String backdrop_path;
  String overview;
  String original_title;

  Movie({
    required this.id,
    required this.vote_average,
    required this.title,
    required this.original_language,
    required this.poster_path,
    required this.release_date,
    required this.backdrop_path,
    required this.overview,
    required this.original_title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'vote_average': this.vote_average,
      'title': this.title,
      'original_language': this.original_language,
      'poster_path': this.poster_path,
      'release_date': this.release_date,
      'backdrop_path': this.backdrop_path,
      'overview': this.overview,
      'original_title': this.original_title,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      vote_average: map['vote_average'] as num,
      title: map['title'] as String,
      original_language: map['original_language'] as String,
      poster_path: map['poster_path'] as String,
      release_date: map['release_date'] as String,
      backdrop_path: map['backdrop_path'] as String,
      overview: map['overview'] as String,
      original_title: map['original_title'] as String,
    );
  }
}