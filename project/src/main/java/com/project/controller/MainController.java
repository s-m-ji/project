package com.project.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.MainService;
import com.project.vo.MainVO;
import com.project.vo.RecipeBoardVo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@Controller
//@EnableCaching
@RequestMapping("/recipe/*")
public class MainController {
   @Autowired
   MainService mainservice;
     
   public static final String ATTACHES_DIR = "c:\\upload\\";
   
   @GetMapping("main")
   public String Main(Model model) { 
      
      // 1. 理쒕떎 異붿쿇  젅 떆 뵾 由ъ뒪 듃 遺덈윭 삤湲 
      List<MainVO> vo1 = mainservice.getBoomUpList();
      for (MainVO BoomUpList: vo1) {
         String BoomUp = BoomUpList.getSavePath().replace("\\", "/");
         //System.out.println("蹂 寃   썑 異쒕젰 ============" + BoomUp);
         BoomUpList.setSavePath(BoomUp);
      }
      
      //model.addAttribute("BoomUpList", mainservice.getBoomUpList());
      model.addAttribute("BoomUpList", vo1);
      
      
      // 2. 理쒕떎 議고쉶  젅 떆 뵾 由ъ뒪 듃 遺덈윭 삤湲 
      List<MainVO> vo2 = mainservice.getViewCntList();
      for (MainVO ViewCntList: vo2) {
         String ViewCnt = ViewCntList.getSavePath().replace("\\", "/");
         //System.out.println("蹂 寃   쟾 異쒕젰 ============" + sP);
         //sP.replace();
         //System.out.println("蹂 寃   썑 異쒕젰 ============" + ViewCnt);
         ViewCntList.setSavePath(ViewCnt);
      }
      model.addAttribute("ViewCntList", vo2);

      // 3. 理쒕떎  뙎湲   젅 떆 뵾 由ъ뒪 듃 遺덈윭 삤湲 
      List<MainVO> vo3 = mainservice.getReplyCntList();
      for (MainVO ReplyCntList: vo3) {
         String ReplyCnt = ReplyCntList.getSavePath().replace("\\", "/");
         //System.out.println("蹂 寃   쟾 異쒕젰 ============" + sP);
         //sP.replace();
         //System.out.println("蹂 寃   썑 異쒕젰 ============" + ReplyCnt);
         ReplyCntList.setSavePath(ReplyCnt);
      }
      model.addAttribute("ReplyCntList", vo3);

      // 4. 理쒓렐  벑濡   젅 떆 뵾 由ъ뒪 듃 遺덈윭 삤湲 
      List<MainVO> vo4 = mainservice.getRecentList();
      for (MainVO RecentList: vo4) {
         String Recent = RecentList.getSavePath().replace("\\", "/");
         //System.out.println("蹂 寃   쟾 異쒕젰 ============" + sP);
         //sP.replace();
         //System.out.println("蹂 寃   썑 異쒕젰 ============" + Recent);
         RecentList.setSavePath(Recent);
      }
      model.addAttribute("RecentList", vo4);

      // 6. 怨듦났 뜲 씠 꽣 open API
      try {
         // 1.  떇以묐룆 吏  뿭蹂   쁽 솴
         URL url1 = new URL(
               "http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2848/json/0/500/OCCRNC_YEAR=2022");

         // 2.  떇以묐룆  썝 씤 떆 꽕蹂   쁽 솴
         URL url2 = new URL(
               "http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2849/json/0/500/OCCRNC_YEAR=2022");

         // 3.  떇以묐룆  썝 씤臾쇱쭏蹂   쁽 솴
         URL url3 = new URL(
               "http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2850/json/0/500/OCCRNC_YEAR=2022");

         // 4. 紐⑤쾾  쓬 떇 젏  쐞移 
         URL url4 = new URL(
               "http://211.237.50.150:7080/openapi/fa423751811a56b9431802ff2e57bd2ceda57c1fd75aa0678d3261d7378eafd0/json/Grid_20200713000000000605_1/0/999");

         String result1 = "";
         String result2 = "";
         String result3 = "";
         String result4 = "";

         BufferedReader bf1;
         BufferedReader bf2;
         BufferedReader bf3;
         BufferedReader bf4;

         bf1 = new BufferedReader(new InputStreamReader(url1.openStream(), "UTF-8"));
         bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));
         bf3 = new BufferedReader(new InputStreamReader(url3.openStream(), "UTF-8"));
         bf4 = new BufferedReader(new InputStreamReader(url4.openStream(), "UTF-8"));

         result1 = bf1.readLine();
         result2 = bf2.readLine();
         result3 = bf3.readLine();
         result4 = bf4.readLine();

         JSONParser jsonParser = new JSONParser();

         // 1.  떇以묐룆 吏  뿭蹂   쁽 솴
         JSONObject jsonObject1 = (JSONObject) jsonParser.parse(result1);
         JSONObject I2848 = (JSONObject) jsonObject1.get("I2848");
         JSONArray row1 = (JSONArray) I2848.get("row");
         List<JSONObject> regionDataList = new ArrayList<>();
         for (int i = 0; i < row1.size(); i++) {
            JSONObject regionData = (JSONObject) row1.get(i);
            regionDataList.add(regionData);
         }
         model.addAttribute("regionData", regionDataList);

         // 2.  떇以묐룆  썝 씤 떆 꽕蹂   쁽 솴
         JSONObject jsonObject2 = (JSONObject) jsonParser.parse(result2);
         JSONObject I2849 = (JSONObject) jsonObject2.get("I2849");
         JSONArray row2 = (JSONArray) I2849.get("row");
         List<JSONObject> locationDataList = new ArrayList<>();
         for (int i = 0; i < row2.size(); i++) {
            JSONObject locationData = (JSONObject) row2.get(i);
            locationDataList.add(locationData);
         }
         model.addAttribute("locationData", locationDataList);

//         // 3.  떇以묐룆  썝 씤臾쇱쭏蹂   쁽 솴
//         JSONObject jsonObject3 = (JSONObject) jsonParser.parse(result3);
//         JSONObject I2850 = (JSONObject) jsonObject3.get("I2850");
//         JSONArray row3 = (JSONArray) I2850.get("row");
//         List<JSONObject> thingDataList = new ArrayList<>();
//         for (int i = 0; i < 10/* row3.size() */; i++) {
//            JSONObject thingData = (JSONObject) row3.get(i);
//            thingDataList.add(thingData);
//            // System.out.println("thingData : " + thingData);
//         }
//         model.addAttribute("thingData", thingDataList);

         // 4.  쓬 떇 젏 由ъ뒪 듃1
         JSONObject jsonObject4 = (JSONObject) jsonParser.parse(result4);
         JSONObject Grid_20200713000000000605_1 = (JSONObject) jsonObject4.get("Grid_20200713000000000605_1");
         JSONArray row4 = (JSONArray) Grid_20200713000000000605_1.get("row");
         List<JSONObject> restarauntList1 = new ArrayList<>();
         for (int i = 0; i < row4.size(); i++) {
            JSONObject restaurantData1 = (JSONObject) row4.get(i);
            restarauntList1.add(restaurantData1);
            // System.out.println("restarauntList1 : " + restarauntList1);
            // System.out.println("thingData : " + thingData);
         }
         // System.out.println("restarauntList1 : " + restarauntList1);
         model.addAttribute("restaurantData1", restarauntList1);

      } catch (Exception e) {
         e.printStackTrace();

      }

         //String email = response.get("email");
         //email.mainservice.checkemail();
         
      return "/recipe/main";
   }
}