class SaveSunModel {
  bool? success;
  String? message;
  int? flaresCount;
  Report? report;

  SaveSunModel({this.success, this.message, this.flaresCount, this.report});

  SaveSunModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    flaresCount = json['flares_count'];
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['flares_count'] = this.flaresCount;
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    return data;
  }
}

class Report {
  int? id;
  String? reportDate;
  int? totalFlares;
  StrongestFlare? strongestFlare;
  double? riskPercentage;
  double? predictionConfidence;

  Report({
    this.id,
    this.reportDate,
    this.totalFlares,
    this.strongestFlare,
    this.riskPercentage,
    this.predictionConfidence,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reportDate = json['report_date'];
    totalFlares = json['total_flares'];
    strongestFlare = json['strongest_flare'] != null
        ? StrongestFlare.fromJson(json['strongest_flare'])
        : null;
    riskPercentage = json['risk_percentage'];
    predictionConfidence = json['prediction_confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['report_date'] = this.reportDate;
    data['total_flares'] = this.totalFlares;
    if (this.strongestFlare != null) {
      data['strongest_flare'] = this.strongestFlare!.toJson();
    }
    data['risk_percentage'] = this.riskPercentage;
    data['prediction_confidence'] = this.predictionConfidence;
    return data;
  }
}

class StrongestFlare {
  int? id;
  String? flareId;
  String? classType;
  String? flareClass;
  double? intensity;
  String? beginTime;
  String? peakTime;
  String? endTime;
  String? riskLevel;
  String? riskColor;
  List<String>? impactEffects;
  String? createdAt;
  String? updatedAt;

  StrongestFlare({
    this.id,
    this.flareId,
    this.classType,
    this.flareClass,
    this.intensity,
    this.beginTime,
    this.peakTime,
    this.endTime,
    this.riskLevel,
    this.riskColor,
    this.impactEffects,
    this.createdAt,
    this.updatedAt,
  });

  StrongestFlare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flareId = json['flare_id'];
    classType = json['class_type'];
    flareClass = json['flare_class'];
    intensity = json['intensity'];
    beginTime = json['begin_time'];
    peakTime = json['peak_time'];
    endTime = json['end_time'];
    riskLevel = json['risk_level'];
    riskColor = json['risk_color'];
    impactEffects = json['impact_effects'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['flare_id'] = this.flareId;
    data['class_type'] = this.classType;
    data['flare_class'] = this.flareClass;
    data['intensity'] = this.intensity;
    data['begin_time'] = this.beginTime;
    data['peak_time'] = this.peakTime;
    data['end_time'] = this.endTime;
    data['risk_level'] = this.riskLevel;
    data['risk_color'] = this.riskColor;
    data['impact_effects'] = this.impactEffects;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
