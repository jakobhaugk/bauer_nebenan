import 'package:flutter/material.dart';

class EcoScore  {
	int distance;
	int ranking;
	int co2;

	EcoScore({this.distance, this.ranking, this.co2});

	factory EcoScore.fromJson(Map<String, dynamic> json) {
		return EcoScore(
			distance: json['distance'],
			ranking: json['ranking'],
			co2: json['co2'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['distance'] = this.distance;
		data['ranking'] = this.ranking;
		data['co2'] = this.co2;
		return data;
	}

  Color get color {
    if (this.ranking > 70)
      return Colors.green;
    else if (this.ranking > 40)
      return Colors.orange;
    else
      return Colors.red;
  }

}
