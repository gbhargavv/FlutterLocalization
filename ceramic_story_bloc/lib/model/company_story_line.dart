class CompanyStoryLine {
  String? storylinesId;
  String? companyStoryId;
  String? storylineText;
  String? productName;
  String? driveUrl;
  String? shotDescription;
  String? shotName;
  String? inspirationName;
  List<ShotList>? shotList;

  CompanyStoryLine(
      {this.storylinesId,
        this.companyStoryId,
        this.storylineText,
        this.productName,
        this.driveUrl,
        this.shotDescription,
        this.shotName,
        this.inspirationName,
        this.shotList});

  CompanyStoryLine.fromJson(Map<String, dynamic> json) {
    storylinesId = json['storylines_id'];
    companyStoryId = json['company_story_id'];
    storylineText = json['storyline_text'];
    productName = json['product_name'];
    driveUrl = json['drive_url'];
    shotDescription = json['shot_description'];
    shotName = json['shot_name'];
    inspirationName = json['inspiration_name'];
    if (json['shot_list'] != null) {
      shotList = <ShotList>[];
      json['shot_list'].forEach((v) {
        shotList!.add(new ShotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storylines_id'] = this.storylinesId;
    data['company_story_id'] = this.companyStoryId;
    data['storyline_text'] = this.storylineText;
    data['product_name'] = this.productName;
    data['drive_url'] = this.driveUrl;
    data['shot_description'] = this.shotDescription;
    data['shot_name'] = this.shotName;
    data['inspiration_name'] = this.inspirationName;
    if (this.shotList != null) {
      data['shot_list'] = this.shotList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShotList {
  String? storylineShotId;
  String? isOk;
  String? video;
  String? videoHeight;
  String? videoWidth;
  String? addedOn;

  ShotList(
      {this.storylineShotId,
        this.isOk,
        this.video,
        this.videoHeight,
        this.videoWidth,
        this.addedOn});

  ShotList.fromJson(Map<String, dynamic> json) {
    storylineShotId = json['storyline_shot_id'];
    isOk = json['is_ok'];
    video = json['video'];
    videoHeight = json['video_height'];
    videoWidth = json['video_width'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storyline_shot_id'] = this.storylineShotId;
    data['is_ok'] = this.isOk;
    data['video'] = this.video;
    data['video_height'] = this.videoHeight;
    data['video_width'] = this.videoWidth;
    data['added_on'] = this.addedOn;
    return data;
  }
}