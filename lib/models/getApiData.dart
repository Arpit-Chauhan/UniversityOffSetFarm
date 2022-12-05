class GetApiData {
  String? alphaTwoCode;
  String? name;
  String? country;
  List<String>? webPages;
  String? stateProvince;
  List<String>? domains;

  GetApiData(
      {this.alphaTwoCode,
      this.name,
      this.country,
      this.webPages,
      this.stateProvince,
      this.domains});

  GetApiData.fromJson(Map<String, dynamic> json) {
    alphaTwoCode = json['alpha_two_code'];
    name = json['name'];
    country = json['country'];
    webPages = json['web_pages'].toList().cast<String>();
    stateProvince = json['state-province'];
    domains = json['domains'].toList().cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alpha_two_code'] = this.alphaTwoCode;
    data['name'] = this.name;
    data['country'] = this.country;
    data['web_pages'] = this.webPages;
    data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    return data;
  }
}