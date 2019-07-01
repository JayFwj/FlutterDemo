class HomeBanner{
  String id;
  String hyperlinkUrl;
  String html;
  String image;

   HomeBanner(this.id, this.hyperlinkUrl, this.html, this.image);

    factory HomeBanner.fromJson(Map map){
      return HomeBanner(map["id"],map["hyperlinkUrl"],map["html"],map["image"]);
    } 
}

//不同的项对象
abstract class HomeDataItem{}

class HomeBannerItem extends HomeDataItem{
    List<HomeBanner> banners;
}

class HomeIndustryItem extends HomeDataItem {}

class HomeRecItem extends HomeDataItem {
  List<HomeBrandDataItem> brandList;
}

class HomeRecTitleItem extends HomeDataItem{
  bool hideMore = false;
  String industryName;
  HomeRecTitleItem(this.industryName,this.hideMore);
}

class HomeBrandData{
  int pageSize;
  int total;
  int page;
  List<HomeBrandTypeItem> brandTypeList;
  HomeBrandData(this.page, this.total, this.pageSize, this.brandTypeList);

  factory HomeBrandData.fromJson(Map map){
      List<HomeBrandTypeItem> brandTypeList =  map["rspInfo"].map<HomeBrandTypeItem>(((map) => HomeBrandTypeItem.fromJson(map))).toList();

      return HomeBrandData(map["page"], map["total"], map["pageSize"],brandTypeList);
    }
}

class HomeBrandTypeItem{
  String typeName;
  List<HomeBrandDataItem> brandList;
  HomeBrandTypeItem(this.typeName, this.brandList);

  factory HomeBrandTypeItem.fromJson(Map map){

  List<HomeBrandDataItem> brandList =  map["rspInfo"].map<HomeBrandDataItem>(((map) => HomeBrandDataItem.fromJson(map))).toList();
    return HomeBrandTypeItem(map["typeName"],brandList);
  }
}

class HomeBrandDataItem extends HomeDataItem{
  String brandId;
  String brandName;
  String id;
  String logo; 

  HomeBrandDataItem(this.brandId, this.brandName, this.id, this.logo);

  factory HomeBrandDataItem.fromJson(Map map){
    return HomeBrandDataItem(map["brandId"],map["brandName"],map["id"],map["logo"]);
  }
}

