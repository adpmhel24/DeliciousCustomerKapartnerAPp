class VersionModel {
  late String platform;
  late String version;
  late int buildNumber;
  late String packageName;
  String? releaseNotes;

  VersionModel({
    required this.platform,
    required this.version,
    required this.buildNumber,
    required this.packageName,
    this.releaseNotes,
  });

  VersionModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    version = json['version'];
    buildNumber = json['buildNumber'];
    packageName = json['packageName'];
    releaseNotes = json['releaseNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['version'] = version;
    data['buildNumber'] = buildNumber;
    data['packageName'] = packageName;
    data['releaseNotes'] = releaseNotes;
    return data;
  }
}
