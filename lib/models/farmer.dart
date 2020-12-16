import "location.dart";

class Farmer  {
	String id;
	String name;
	String profileImage;
	String bannerImage;
	String description;
	String quote;
	String subtitle;
	Location location;

	Farmer({this.id, this.name, this.profileImage, this.bannerImage, this.description, this.quote, this.location, this.subtitle});

	factory Farmer.fromJson(Map<String, dynamic> json) {
		return Farmer(
			id: json['id'],
			name: json['name'],
			profileImage: json['profileImage'],
			bannerImage: json['bannerImage'],
			description: json['description'],
			quote: json['quote'],
      subtitle: json['subtitle'],
			location: json['location'] != null ? new Location.fromJson(json['location']) : null,
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['profileImage'] = this.profileImage;
		data['bannerImage'] = this.bannerImage;
		data['description'] = this.description;
		data['quote'] = this.quote;
    data['subtitle'] = this.subtitle;
		if (this.location != null) {
      data['location'] = this.location.toJson();
    }
		return data;
	}


}
