class GetStartedPageData {
  late final String _pageTitle;
  late final String _pageSubTitle;
  late final String _imageUrl;
  late final String _pageName;

  GetStartedPageData(
      {required String pageTitle,
      required String subTitle,
      required String imgUrl,
      required String pageName}) {
    _pageTitle = pageTitle;
    _pageSubTitle = subTitle;
    _imageUrl = imgUrl;
    _pageName = pageName;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get pageSubTitle => _pageSubTitle;

  set pageSubTitle(String value) {
    _pageSubTitle = value;
  }

  String get pageTitle => _pageTitle;

  set pageTitle(String value) {
    _pageTitle = value;
  }

  String get pageName => _pageName;

  set pageName(String value) {
    _pageName = value;
  }
}
