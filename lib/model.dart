class RecipeModel {
  late String applabel;
  late String appimgeurl;
  late double appcalories;
  late String appurl;
  RecipeModel(
      {this.applabel = "LABEL",
      this.appimgeurl = "appimageurl",
      this.appurl = "appurl",
      this.appcalories = 0.000});

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
        applabel: recipe["label"],
        appcalories: recipe["calories"],
        appimgeurl: recipe["image"],
        appurl: recipe["url"]);
  }
}
