import 'package:meta/meta.dart';

class SupportNumber {
  final int id;
  final String phone;

  SupportNumber({@required this.id, @required this.phone})
      : assert(id != null, phone != null);
}
