const String tableContactColId='id';
const String tableContactColName='name';
const String tableContactColNumber='number';
const String tableContactColDesignation='designation';
const String tableContactColEmail='email';
const String tableContactColAddress='address';
const String tableContactColDob='doJoin';
const String tableContactColZone='zone';
const String tableContactColCircle='circle';
const String tableContactColImage='image';


class ContactModel{
  String? id;
  String? name;
  String? number;
  String? designation;
  String? email;
  String? address;
  String? zone;
  String? circle;
  String? doJoin;
  String? image;

  ContactModel(
      {this.id,
      this.name,
      this.number,
      this.designation,
      this.email,
      this.address,
      this.zone,
      this.circle,
      this.doJoin,
      this.image});


  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      tableContactColId:id,
      tableContactColName:name,
      tableContactColNumber:number,
      tableContactColDesignation:designation,
      tableContactColEmail:email,
      tableContactColAddress:address,
      tableContactColZone:zone,
      tableContactColCircle:circle,
      tableContactColDob:doJoin,
      tableContactColImage:image,

    };

    return map;
  }

  factory ContactModel.fromMap(Map<dynamic, dynamic> map)=>
      ContactModel(
    id : map[tableContactColId],
    name: map[tableContactColName],
    number: map[tableContactColNumber],
    designation: map[tableContactColDesignation],
    email: map[tableContactColEmail],
    address: map[tableContactColAddress],
    doJoin: map[tableContactColDob],
    zone: map[tableContactColZone],
    circle: map[tableContactColCircle],
    image: map[tableContactColImage],

  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, number: $number, designation: $designation, email: $email, address: $address, zone: $zone, circle: $circle, doJoin: $doJoin, image: $image}';
  }
}