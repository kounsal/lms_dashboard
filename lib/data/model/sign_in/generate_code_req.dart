class GenerateCodeReq {
  final String email;


  GenerateCodeReq({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}