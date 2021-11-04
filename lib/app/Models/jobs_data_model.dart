class Jobs {
  const Jobs(this.name, this.ratePerHour);

  final String? name;
  final int? ratePerHour;

  Map<String, dynamic> toMap() {
    return {"name": name, "ratePerHour": ratePerHour};
  }
}
