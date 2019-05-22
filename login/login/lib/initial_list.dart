import './task.dart';
import 'package:flutter/material.dart';


List<Task> tasks = [

  new Task(
      name: "Take Paracetomol And Dolopar ",
      category: "50 mg of Paracetomol(Half Tablet)+100mg of Crocin(1- Tablet)",
      time: "2PM - 2:30PM",
      color: Colors.red,
      completed: false),
  new Task(
      name: "Apply Eucalyptus oil",
      category: "Over Head and Nose",
      time: "By 12 PM",
      color: Colors.green,
      completed: true),
  new Task(
      name: "Take Paracetomol",
      category: "100mg(1 Tablet)",
      time: "Before 9 AM",
      color: Colors.green,
      completed: true),
];