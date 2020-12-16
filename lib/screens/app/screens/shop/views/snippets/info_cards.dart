import 'package:bauer_nebenan/models/eco_score.dart';
import 'package:bauer_nebenan/models/farmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../widgets/row_card.dart';

class FarmerInfo extends StatelessWidget {
  final Farmer farmer;

  const FarmerInfo({Key key, this.farmer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowCard(
      height: 60,
      padding: 6,
      onTap: () {},
      leading: CachedNetworkImage(imageUrl: farmer.profileImage),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            farmer.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (farmer.subtitle != null)
            Text(
              farmer.subtitle,
            ),
        ],
      ),
    );
  }
}

class EcoInfo extends StatelessWidget {
  final EcoScore ecoScore;

  const EcoInfo({Key key, this.ecoScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowCard(
      height: 60,
      padding: 6,
      leading: CircularPercentIndicator(
        radius: 53.0,
        lineWidth: 7,
        percent: ecoScore.ranking.toDouble() / 100.0,
        progressColor: ecoScore.color,
        animation: true,
        animationDuration: 2000,
        curve: Curves.easeOutQuint,
        startAngle: 0,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          ecoScore.ranking.toString(),
          style: TextStyle(color: ecoScore.color, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${ecoScore.distance} km Transport'),
          Text('${ecoScore.co2} g CO\u2082 Ausstoß'),
        ],
      ),
    );
  }
}
