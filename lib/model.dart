class RecipeModel{
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;

  RecipeModel({this.appcalories = 0.00,  this.appimgurl = 'imgurl', this.applabel = 'label', this.appurl ='url'});
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      applabel: recipe['label'],
      appimgurl: recipe['image'],
      appcalories: recipe['calories'],
      appurl: recipe['url']

    );
  }
}