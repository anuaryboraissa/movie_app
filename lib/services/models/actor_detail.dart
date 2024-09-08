class ActorDetail {
	bool? adult;
	List<dynamic>? alsoKnownAs;
	String? biography;
	String? birthday;
	dynamic deathday;
	int? gender;
	dynamic homepage;
	int? id;
	String? imdbId;
	String? knownForDepartment;
	String? name;
	String? placeOfBirth;
	double? popularity;
	String? profilePath;

	ActorDetail({
		this.adult, 
		this.alsoKnownAs, 
		this.biography, 
		this.birthday, 
		this.deathday, 
		this.gender, 
		this.homepage, 
		this.id, 
		this.imdbId, 
		this.knownForDepartment, 
		this.name, 
		this.placeOfBirth, 
		this.popularity, 
		this.profilePath, 
	});

	factory ActorDetail.fromJson(Map<String, dynamic> json) => ActorDetail(
				adult: json['adult'] as bool?,
				alsoKnownAs: json['also_known_as'] as List<dynamic>?,
				biography: json['biography'] as String?,
				birthday: json['birthday'] as String?,
				deathday: json['deathday'] as dynamic,
				gender: json['gender'] as int?,
				homepage: json['homepage'] as dynamic,
				id: json['id'] as int?,
				imdbId: json['imdb_id'] as String?,
				knownForDepartment: json['known_for_department'] as String?,
				name: json['name'] as String?,
				placeOfBirth: json['place_of_birth'] as String?,
				popularity: (json['popularity'] as num?)?.toDouble(),
				profilePath: json['profile_path'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'adult': adult,
				'also_known_as': alsoKnownAs,
				'biography': biography,
				'birthday': birthday,
				'deathday': deathday,
				'gender': gender,
				'homepage': homepage,
				'id': id,
				'imdb_id': imdbId,
				'known_for_department': knownForDepartment,
				'name': name,
				'place_of_birth': placeOfBirth,
				'popularity': popularity,
				'profile_path': profilePath,
			};
}
