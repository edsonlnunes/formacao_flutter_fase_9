import 'package:deck_app/shared/entities/question.entity.dart';
import 'package:flutter/foundation.dart';

class Deck {
  final int id;
  final String name;
  final List<Question> questions;

  Deck({
    required this.id,
    required this.name,
    this.questions = const [],
  });

  Deck copyWith({
    int? id,
    String? name,
    List<Question>? questions,
  }) {
    return Deck(
      id: id ?? this.id,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      id: map['id'] as int,
      name: map['name'] as String,
      questions: List<Question>.from(
        map['questions'].map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool operator ==(covariant Deck other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ questions.hashCode;
}
