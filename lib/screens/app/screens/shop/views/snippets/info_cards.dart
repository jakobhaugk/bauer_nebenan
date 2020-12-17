import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:bauer_nebenan/models/eco_score.dart';
import 'package:bauer_nebenan/models/farmer.dart';
import '../../../widgets/row_card.dart';

class ProductFarmerInfo extends StatelessWidget {
  final Farmer farmer;

  const ProductFarmerInfo({Key key, this.farmer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowCard(
      height: 60,
      topPadding: 6,
      onTap: () {},
      leading: CachedNetworkImage(imageUrl: farmer.profileImage),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            farmer.name,
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
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

class ProductEcoInfo extends StatelessWidget {
  final EcoScore ecoScore;

  const ProductEcoInfo({Key key, this.ecoScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowCard(
      height: 60,
      topPadding: 6,
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
