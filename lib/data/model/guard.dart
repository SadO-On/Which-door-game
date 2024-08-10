class Guard {
  final String id;
  final int age;
  final String name;
  final String expiryDate;
  final String gender;
  final String eId;
  final String nationality;
  final String bloodType;
  String? idBarCode;
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
    this.idBarCode,
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
      age: DateTime.now().year - 1986,
      name: "Steve",
      expiryDate: '01/12/2029',
      gender: "Male",
      slogan: "Patience is not my virtue.",
      idAsset: "assets/images/steve_id.svg",
      eId: '38292',
      nationality: 'Quarls',
      bloodType: 'O+',
      asset: 'assets/rive/steve_id_animation.riv',
      phoneNum: '+99 012 345 6789',
      joinedDate: '09/04/2020'),
  "willy": Guard(
      id: '6389940321',
      age: DateTime.now().year - 1970,
      name: "Willy",
      expiryDate: '01/12/2029',
      gender: "Male",
      slogan: "I'm too old for this nonsense.",
      eId: '38292',
      idAsset: "assets/images/willy_id.svg",
      nationality: 'Quarls',
      bloodType: 'B+',
      asset: 'assets/rive/willy_id_animation.riv',
      phoneNum: '+99 094 773 8928',
      joinedDate: '05/19/2015'),
  "sam": Guard(
      id: "8332719001",
      age: DateTime.now().year - 1998,
      name: "Sam",
      expiryDate: "01/11/2028",
      gender: "Male",
      idAsset: "assets/images/sam_id.svg",
      eId: "93318",
      slogan: "The quiet one sees all.",
      asset: 'assets/rive/sam_id_animation.riv',
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
      asset: 'assets/rive/fred_id_animation.riv',
      phoneNum: '+99 676 778 3227',
      joinedDate: '24/12/2002'),
  "fred_fake_id": Guard(
      id: '4355625736',
      age: DateTime.now().year - 1966,
      name: "Fred",
      expiryDate: '01/12/2029',
      gender: "Male",
      eId: '12575',
      nationality: 'Vaelorian',
      idAsset: "assets/images/fred_fake_id.svg",
      bloodType: 'A+',
      slogan: "In questions, find the truth.",
      asset: 'assets/rive/steve_id_animation.riv',
      phoneNum: '+99 676 778 3227',
      joinedDate: '24/12/2002',
      idBarCode: "4265284222"),
  "margaret": Guard(
      id: '4355625719',
      age: DateTime.now().year - 1990,
      name: "Margaret",
      expiryDate: '01/12/2029',
      gender: "Female",
      eId: '56382',
      nationality: 'Vaelorian',
      idAsset: "assets/images/margaret_id.svg",
      bloodType: 'O+',
      slogan: "The trickier, the better.",
      asset: 'assets/rive/margaret_id_animation.riv',
      phoneNum: '+99 636 332 3227',
      joinedDate: '24/12/2010',
      idBarCode: "4355625719"),
  "kane": Guard(
      id: '1021009303',
      age: DateTime.now().year - 1993,
      name: "Kane",
      expiryDate: '12/11/2026',
      gender: "Male",
      eId: '56382',
      nationality: 'Zyntrian',
      idAsset: "assets/images/kane_id.svg",
      bloodType: 'O+',
      slogan: "The trickier, the better.",
      asset: 'assets/rive/kane_id_animation.riv',
      phoneNum: '+99 636 332 3227',
      joinedDate: '24/12/2010',
      idBarCode: "1021009303"),
};
