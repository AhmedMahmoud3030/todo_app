class TaskModel {
  String? id;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? remind;
  String? repeat;
  bool isFavorite;
  bool isCompleted;

  TaskModel({
    this.id,
    this.title,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
    this.isFavorite = false,
    this.isCompleted = false,
  });
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      startTime: map['starttime'],
      endTime: map['endtime'],
      remind: map['remind'],
      repeat: map['repeat'],
      isFavorite: map['isFavorite'],
      isCompleted: map['isCompleted'],
    );
  }
}
