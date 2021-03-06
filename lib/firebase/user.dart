import 'package:flutter/material.dart';

class User {
  String uid;
  String username;
  bool presence;
  int lastSeenInEpoch;

  User({
    @required this.username,
    @required this.presence,
    @required this.lastSeenInEpoch,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    presence = json['presence'];
    lastSeenInEpoch = json['last_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['username'] = this.username;
    data['presence'] = this.presence;
    data['last_seen'] = this.lastSeenInEpoch;

    return data;
  }
}
