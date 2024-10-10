
class Tasks {
  List<Task>? task;

  Tasks({this.task});

  Tasks.fromJson(Map<String, dynamic> json) {
    if (json['task'] != null) {
      task = <Task>[];
      json['task'].forEach((v) {
        task!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (task != null) {
      data['task'] = task!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  String? name;
  String? description;
  int? deadline;
  int? priority;
  int? status;
  int? created;
  int? updated;

  Task(
      {this.name,
        this.description,
        this.deadline,
        this.priority,
        this.status,
        this.created,
        this.updated});

  Task.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    deadline = json['deadline'];
    priority = json['priority'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['deadline'] = deadline;
    data['priority'] = priority;
    data['status'] = status;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}