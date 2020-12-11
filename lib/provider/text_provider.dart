import '../util/fetch.dart';
import 'package:flutter/foundation.dart';

class TextProvider extends ChangeNotifier {
  Map text;

  Future<Map> load() async {
    //text = await fetch('get', 'init');
    text = {
      'waitingListText': 'Leider sind wir in deiner Region noch nicht am Start.\nSobald es losgeht, geben wir dir per E-Mail Bescheid',
      'welcomeText': 'Herzlich willkommen in der Bauer Nebenan Community!\nSchau direkt im Shop vorbei und bestelle deinen ersten regionalen Wocheneinkauf.',
      'nextCity': 'Gießen',
      'privacyPolicyURL': 'https://bauer-nebenan.de/'
    };
    return text;
  }
}