import 'contact_model.dart';

const String tableInfoColId='id';
const String tableInfoColEmpId='emp_id';
const String tableInfoColEmpName='name';
const String tableInfoColTo='to';
const String tableInfoColFrom='from';
const String tableInfoColDate='transferDate';


class TransferLogModel{
  String? id;
  String empId;
  String empName;
  String transferTo;
  String transferFrom;
  String transferDate;

  TransferLogModel({
    this.id,
   required this.empId,
   required this.empName,
   required this.transferTo,
   required this.transferFrom,
   required this.transferDate});

  Map<String,dynamic> toMap(){

    var map=<String,dynamic>{
      tableInfoColId:id,
      tableInfoColEmpId:empId,
      tableInfoColEmpName:empName,
      tableInfoColTo:transferTo,
      tableInfoColFrom:transferFrom,
      tableInfoColDate:transferDate,
    };

    return map;
  }


  factory TransferLogModel.fromMap(Map<dynamic, dynamic> map)=>
    TransferLogModel(
      id: map[tableInfoColId],
      empId : map[tableInfoColEmpId],
      empName: map[tableInfoColEmpName],
      transferTo: map[tableInfoColTo],
      transferFrom: map[tableInfoColFrom],
      transferDate: map[tableInfoColDate],
    );
}