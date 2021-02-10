class User {
  int _id;
  String _name;
  String _description;
  String _pic;
  String _email;
  String _password;

  User(this._id, this._name, this._description, this._pic, this._email,
      this._password);

  int get id => _id;

  set id(int value) => _id = value;

  String get name => _name;

  set name(String value) => _name = value;

  String get description => _description;

  set description(String value) => _description = value;

  String get pic => _pic;

  set pic(String value) => _pic = value;

  String get email => _email;

  set email(String value) => _email = value;

  String get password => _password;

  set password(String value) => _password = value;
}
