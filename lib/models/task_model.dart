


class Tasks {
  final int? task_id;
  final String? task_name;
  final String? task_description;
  final String? task_date;
  final String? task_status;

  Tasks(
      {this.task_id,
      this.task_name,
      this.task_description,
      this.task_date,
      this.task_status});


  Map<String, dynamic> toTaskMap() {

    return {
      'task_id': task_id,
      'task_name': task_name,
      'task_date': task_date,
      'task_description': task_description,
      'task_status': task_status,
    };
  }
}

