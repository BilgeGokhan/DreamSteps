class CompletionConfig {
  final String colorHex;
  final String animationFile;
  final String messageSoft;
  final String messageMotivational;
  final String messagePro;
  final String cta;

  CompletionConfig({
    required this.colorHex,
    required this.animationFile,
    required this.messageSoft,
    required this.messageMotivational,
    required this.messagePro,
    required this.cta,
  });

  factory CompletionConfig.fromJson(Map<String, dynamic> json) {
    return CompletionConfig(
      colorHex: json['color'] as String,
      animationFile: json['animation'] as String,
      messageSoft: json['message_soft'] as String,
      messageMotivational: json['message_motivational'] as String,
      messagePro: json['message_pro'] as String,
      cta: json['cta'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': colorHex,
      'animation': animationFile,
      'message_soft': messageSoft,
      'message_motivational': messageMotivational,
      'message_pro': messagePro,
      'cta': cta,
    };
  }
}

