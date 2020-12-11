class Category  {
	String id;
	String name;
	String imageUrl;

	Category({this.id, this.name, this.imageUrl});

	factory Category.fromJson(Map<String, dynamic> json) {
		return Category(
			id: json['id'],
			name: json['name'],
			imageUrl: json['imageURL'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['imageURL'] = this.imageUrl;
		return data;
	}


}
