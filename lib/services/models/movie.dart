class Movie {
	String? backdropPath;
	int? id;
	String? title;
	String? originalTitle;
	String? overview;
	String? posterPath;
	String? mediaType;
	bool? adult;
	String? originalLanguage;
	List<int>? genreIds;
	double? popularity;
	String? releaseDate;
	bool? video;
	int? voteAverage;
	int? voteCount;

	Movie({
		this.backdropPath, 
		this.id, 
		this.title, 
		this.originalTitle, 
		this.overview, 
		this.posterPath, 
		this.mediaType, 
		this.adult, 
		this.originalLanguage, 
		this.genreIds, 
		this.popularity, 
		this.releaseDate, 
		this.video, 
		this.voteAverage, 
		this.voteCount, 
	});

	factory Movie.fromJson(Map<String, dynamic> json) => Movie(
				backdropPath: json['backdrop_path'] as String?,
				id: json['id'] as int?,
				title: json['title'] as String?,
				originalTitle: json['original_title'] as String?,
				overview: json['overview'] as String?,
				posterPath: json['poster_path'] as String?,
				mediaType: json['media_type'] as String?,
				adult: json['adult'] as bool?,
				originalLanguage: json['original_language'] as String?,
				genreIds: json['genre_ids'] as List<int>?,
				popularity: (json['popularity'] as num?)?.toDouble(),
				releaseDate: json['release_date'] as String?,
				video: json['video'] as bool?,
				voteAverage: json['vote_average'] as int?,
				voteCount: json['vote_count'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'backdrop_path': backdropPath,
				'id': id,
				'title': title,
				'original_title': originalTitle,
				'overview': overview,
				'poster_path': posterPath,
				'media_type': mediaType,
				'adult': adult,
				'original_language': originalLanguage,
				'genre_ids': genreIds,
				'popularity': popularity,
				'release_date': releaseDate,
				'video': video,
				'vote_average': voteAverage,
				'vote_count': voteCount,
			};
}
