class Location {
	final String geoLocation;
	final String address;
	final String distance;

	Location({this.geoLocation, this.address, this.distance});

	factory Location.fromJson(Map<String, dynamic> json) {
		return Location(
			geoLocation: json['geoLocation'],
			address: json['address'],
			distance: json['distance'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['geoLocation'] = this.geoLocation;
		data['address'] = this.address;
		data['distance'] = this.distance;
		return data;
	}

}
