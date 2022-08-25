class TaskModel {
  var taskNumber;
  var problem;
  var date;

  TaskModel(
      {required this.taskNumber, required this.problem, required this.date});

  Map<String, dynamic> addTaskAdmin() =>
      {'taskNumber': taskNumber, 'problem': problem, 'date': date};

  Map<String, dynamic> addDoneTask() =>
      {'taskNumber': taskNumber, 'problem': problem};
}
