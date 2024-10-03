class Voter {
  final String name;
  final String email;
  final String dob;
  final String aadharCard;
  final String phone;
  final String photo;

  Voter({
    required this.name,
    required this.email,
    required this.dob,
    required this.aadharCard,
    required this.phone,
    required this.photo,
  });

  factory Voter.fromJson(Map<String, dynamic> json) {
    return Voter(
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      aadharCard: json['aadhar_card'],
      phone: json['phone'],
      photo: json['photo'],
    );
  }
}
