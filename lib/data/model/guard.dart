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
  final String slogan;
  final String joinedDate;
  final String idAsset;

  Guard({
    required this.id,
    required this.age,
    required this.name,
    required this.expiryDate,
    required this.gender,
    required this.eId,
    this.slogan = "",
    this.idAsset = "",
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
      joinedDate: '09/04/2020'),
  "sam": Guard(
      id: "8332719001",
      age: DateTime.now().year - 1998,
      name: "Sam",
      expiryDate: "01/11/2028",
      gender: "Male",
      idAsset: "assets/images/sam_id.svg",
      eId: "93318",
      slogan: "The quiet one sees all.",
      asset: 'assets/rive/steve_id_animation.riv',
      nationality: "Elarian",
      bloodType: "B+",
      phoneNum: "+99 087 455 3031",
      joinedDate: "01/07/2019"),
  "fred": Guard(
      id: '4355625736',
      age: DateTime.now().year - 1966,
      name: "Fred",
      expiryDate: '01/12/2029',
      gender: "Male",
      eId: '12575',
      nationality: 'Vaelorian',
      idAsset: "assets/images/fred_id.svg",
      bloodType: 'A+',
      slogan: "In questions, find the truth.",
      asset: 'assets/rive/steve_id_animation.riv',
      phoneNum: '+99 676 778 3227',
      joinedDate: '24/12/2002')
};
