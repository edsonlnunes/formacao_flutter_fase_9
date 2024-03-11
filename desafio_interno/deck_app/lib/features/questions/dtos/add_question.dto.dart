class AddQuestionDTO {
  final int deckId;
  final String ask;
  final String answer;

  const AddQuestionDTO({
    required this.deckId,
    required this.ask,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ask': ask,
      'answer': answer,
    };
  }
}
