class Employee {
  int? id;
  String name;
  String gender;
  String skills;

  Employee(
      {this.id,
      required this.name,
      required this.gender,
      required this.skills});

  // Chuyển từ Map -> Employee
  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        skills: json['skills'],
      );

  // Chuyển từ Employee -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'skills': skills,
    };
  }
}
