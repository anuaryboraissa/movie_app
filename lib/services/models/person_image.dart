class PersonImage {
	double? aspectRatio;
	int? height;
	dynamic iso6391;
	String? filePath;
	double? voteAverage;
	int? voteCount;
	int? width;

	PersonImage({
		this.aspectRatio, 
		this.height, 
		this.iso6391, 
		this.filePath, 
		this.voteAverage, 
		this.voteCount, 
		this.width, 
	});

	factory PersonImage.fromJson(Map<String, dynamic> json) => PersonImage(
				aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
				height: json['height'] as int?,
				iso6391: json['iso_639_1'] as dynamic,
				filePath: json['file_path'] as String?,
				voteAverage: (json['vote_average'] as num?)?.toDouble(),
				voteCount: json['vote_count'] as int?,
				width: json['width'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'aspect_ratio': aspectRatio,
				'height': height,
				'iso_639_1': iso6391,
				'file_path': filePath,
				'vote_average': voteAverage,
				'vote_count': voteCount,
				'width': width,
			};
}
