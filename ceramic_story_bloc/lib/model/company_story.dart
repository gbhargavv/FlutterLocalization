class CompanyStory {
  String? companyStoryId;
  String? storyHeading;
  String? video;
  String? videoHeight;
  String? videoWidth;

  CompanyStory(
      {this.companyStoryId,
        this.storyHeading,
        this.video,
        this.videoHeight,
        this.videoWidth});

  CompanyStory.fromJson(Map<String, dynamic> json) {
    companyStoryId = json['company_story_id'];
    storyHeading = json['story_heading'];
    video = json['video'];
    videoHeight = json['video_height'];
    videoWidth = json['video_width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_story_id'] = this.companyStoryId;
    data['story_heading'] = this.storyHeading;
    data['video'] = this.video;
    data['video_height'] = this.videoHeight;
    data['video_width'] = this.videoWidth;
    return data;
  }
}