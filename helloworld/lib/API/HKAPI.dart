import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './Home/HomeModel.dart';
import 'mall/MallDataModel.dart';

class HKAPI{

  static HKAPI shaderInstance = HKAPI();
 
  static const String httpMainAddr = "https://www.fuwuniao.com:28000/hk/";

  static const String homeBannerUrl = httpMainAddr + "bd/api/banner/list";

  static const String homeBrandUrl = httpMainAddr + "sbm/api/recomment/find_recomment_brand?page=1&pageSize=50";

  static const String mallListUrl = httpMainAddr + "spm/api/goods/find_product";

  static const String mallSubmenutUrl = httpMainAddr + "spm/api/category/find_sub_category";

  static const String findProductByCateUrl = httpMainAddr + "spm/api/goods/find_product_by_cat";

  Future<List<HomeBanner>> homeBanner() async{  
    var response = await http.get(homeBannerUrl);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data']; 
        var tempList = result
            .map<HomeBanner>((json) => HomeBanner.fromJson(json)).toList();
            // .toList();
         return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return List();
      }
  } 
  
   Future<HomeBrandData> homeBrand() async{  
    var response = await http.get(homeBrandUrl);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data'];
        var tempList = HomeBrandData.fromJson(result);
         
         return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }
  }    
 

  Future<MallDataModel> mallList(int isRecommend, int page, int pageSize, String brandId) async{  

    var url = mallListUrl + "?isRecommend=$isRecommend&page=$page&pageSize=$pageSize&brandId=$brandId";

    var response = await http.get(url);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data'];
        var tempList = MallDataModel.fromJson(result); 
        return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }
  } 

  Future<List<MallDataRpcModel>> mallSubmenut(String id) async{  

    var url = mallSubmenutUrl + "?id=$id";

    var response = await http.get(url);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data'];
        var tempList = result
            .map<MallDataRpcModel>((json) => MallDataRpcModel.fromJson(json)).toList();
        return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }
  }   

  //  请求URL: findProductByCate
// 请求param: {"pageSize":20,"page":1,"productCatId":"f4e51a76aba34174b8e32518849ae997","brandId":"5cb2f7b687ea44f980bd6bfea5f99077","productSubCatId":""}

Future<MallDataModel> findProductByCate(String productCatId, String productSubCatId, int page, int pageSize, String brandId) async{  

    var url = findProductByCateUrl+ "?productCatId=$productCatId&page=$page&pageSize=$pageSize&brandId=$brandId&productSubCatId=$productSubCatId";

    var response = await http.get(url);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data'];
        var tempList = MallDataModel.fromJson(result); 
        return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }
  }
 













}
 