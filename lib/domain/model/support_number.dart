class SupportNumber {
  final String phone;

  const SupportNumber(this.phone) : assert(phone != null);

  String get tel => "tel://$phone";
}
