class StudentInfo {
  String? name;
  String? address;
  String? mobileNo;
  String? date;

  StudentInfo({ this.name,  this.address,  this.mobileNo,  this.date});
  StudentInfo.fromMap(Map<String,dynamic>map){
    name=map["name"];
    address=map["address"];
    mobileNo=map["mobileNo"];
    date=map["date"];
  }
}