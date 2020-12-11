import '../util/base64.dart';
import 'address.dart';

enum UserStatus { unregistered, waiting, unlocked, complete, firstLogin, firstLaunch }

class User {
  String username, password, firstName, lastName;
  Address address;
  bool accetpsMarketing, acceptsPrivacyPolicy;
  UserStatus status;

  User({
      this.username = '',
      this.password = '',
      this.address,
      this.accetpsMarketing = false,
      this.acceptsPrivacyPolicy = false,
      this.status,
      this.firstName = '',
      this.lastName = ''
      }) {
    address ??= Address();
  }

  factory User.fromStorage(Map<String, String> storage) => User(
        username: storage['username'],
        password: storage['password'],
      );

  factory User.fromJSON(Map json, {User former}) => User(
        firstName: json['firstName'] ?? former.firstName,
        lastName: json['lastName'] ?? former.lastName,
        username: json['username'] ?? former.username,
        password: json['password'] ?? former.password,
        status: UserStatus.values
                .firstWhere((e) => e.toString() == json['userStatus']) ??
            UserStatus.unregistered,
        address: Address.fromJSON(json['address']) ?? null,
      );

  Map<String, dynamic> toJSON() => {
        'username': this.username ?? '',
        'address': this.address?.toJSON(),
      };

  String get basicAuth => 'Basic ${toBase64('$username:$password')}';
  Map get authHeader => {'Authorization': this.basicAuth};
  Map get loginBody => {'username': username, 'password': password};

  bool get isEmpty => username == null || password == null;

  bool get readyToShop => status == UserStatus.unlocked || status == UserStatus.complete;

  setNames({first, last}) {
    if (first != null) firstName = first;
    if (last != null) lastName = last;
  }

  setAddress({street, zip, city}) {
    this.address.setAddress(street: street, zip: zip, city: city);
  }
}
