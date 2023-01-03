class ModelFormular {  // ModelMesaj
  String? nume;
  String? email;
  String? telefon;

  ModelFormular(
      { this.nume,  this.email, this.telefon});

  factory ModelFormular.fromJson(Map<String, dynamic> json) {
    return ModelFormular(
      nume: json['nume'] as String,
      email: json['email'] as String,
      telefon: json['telefon'] as String,
    );
  }
}
