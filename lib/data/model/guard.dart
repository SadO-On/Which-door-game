class Guard {
  final String id;
  final int age;
  final String name;
  final String expiryDate;
  final String gender;
  final String eId;
  final String nationality;
  final String bloodType;
  final String phoneNum;
  final String asset;
  final String joinedDate;

  Guard({
    required this.id,
    required this.age,
    required this.name,
    required this.expiryDate,
    required this.gender,
    required this.eId,
    required this.asset,
    required this.nationality,
    required this.bloodType,
    required this.phoneNum,
    required this.joinedDate,
  });
}

final guards = {
  "steve": Guard(
      id: '6029839832',
      age: 37,
      name: "Steve",
      expiryDate: '01/12/2029',
      gender: "Male",
      eId: '38292',
      nationality: 'Quarls',
      bloodType: 'O+',
      asset: 'assets/rive/steve_id_animation.riv',
      phoneNum: '+99 012 345 6789',
      joinedDate: '09/04/2020'),
  "willy": Guard(
      id: '6389940321',
      age: 42,
      name: "Willy",
      expiryDate: '01/12/2029',
      gender: "Male",
      eId: '38292',
      nationality: 'Quarls',
      bloodType: 'B+',
      asset: 'assets/rive/steve_id_animation.riv',
      phoneNum: '+99 012 345 6789',
      joinedDate: '09/04/2020')
};
