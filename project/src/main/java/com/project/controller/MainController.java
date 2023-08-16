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
	
//	@GetMapping("/file/list/{bno}")
//	public @ResponseBody Map<String, Object> fileuploadList
//							(@PathVariable("bno") int bno) {
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("list", service.getList(bno));
//		
//		return map;
//	}
	
	/*
	 * @GetMapping("/displayff") // 이미지를 화면에 보여줍니다 public ResponseEntity<byte[]>
	 * display(String fileName) { //log.info("=====fileName : " + fileName);
	 * //fileName="2023\\08\\03\\오징어동그랑땡.jpg";
	 * 
	 * try { // 파일 객체를 생성 File file = new File(ATTACHES_DIR + fileName);
	 * System.out.println(ATTACHES_DIR + fileName); HttpHeaders headers = new
	 * HttpHeaders();
	 * 
	 * // 이미지 파일이 존재하면 파일을 이미지를 다운로드 if(file.exists()) { // Mime타입을 설정
	 * headers.add("Content-Type",Files.probeContentType(file.toPath())); return new
	 * ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers,
	 * HttpStatus.OK); }else { return new ResponseEntity<>(HttpStatus.NOT_FOUND); }
	 * 
	 * } catch (IOException e) { return new
	 * ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); }
	 * 
	 * }
	 */
	
	@GetMapping("main")
	public String Main(Model model) { 
		
		// 1. 최다 추천 레시피 리스트 불러오기
		List<MainVO> vo1 = mainservice.getBoomUpList();
		for (MainVO BoomUpList: vo1) {
			String BoomUp = BoomUpList.getSavePath().replace("\\", "/");
			//System.out.println("변경 후 출력 ============" + BoomUp);
			BoomUpList.setSavePath(BoomUp);
		}
		
		//model.addAttribute("BoomUpList", mainservice.getBoomUpList());
		model.addAttribute("BoomUpList", vo1);
		
		
		// 2. 최다 조회 레시피 리스트 불러오기
		List<MainVO> vo2 = mainservice.getViewCntList();
		for (MainVO ViewCntList: vo2) {
			String ViewCnt = ViewCntList.getSavePath().replace("\\", "/");
			//System.out.println("변경 전 출력 ============" + sP);
			//sP.replace();
			//System.out.println("변경 후 출력 ============" + ViewCnt);
			ViewCntList.setSavePath(ViewCnt);
		}
		model.addAttribute("ViewCntList", vo2);

		// 3. 최다 댓글 레시피 리스트 불러오기
		List<MainVO> vo3 = mainservice.getReplyCntList();
		for (MainVO ReplyCntList: vo3) {
			String ReplyCnt = ReplyCntList.getSavePath().replace("\\", "/");
			//System.out.println("변경 전 출력 ============" + sP);
			//sP.replace();
			//System.out.println("변경 후 출력 ============" + ReplyCnt);
			ReplyCntList.setSavePath(ReplyCnt);
		}
		model.addAttribute("ReplyCntList", vo3);

		// 4. 최근 등록 레시피 리스트 불러오기
		List<MainVO> vo4 = mainservice.getRecentList();
		for (MainVO RecentList: vo4) {
			String Recent = RecentList.getSavePath().replace("\\", "/");
			//System.out.println("변경 전 출력 ============" + sP);
			//sP.replace();
			//System.out.println("변경 후 출력 ============" + Recent);
			RecentList.setSavePath(Recent);
		}
		model.addAttribute("RecentList", vo4);

		// 6. 공공데이터 open API
		try {
			// 1. 식중독 지역별 현황
			URL url1 = new URL(
					"http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2848/json/0/500/OCCRNC_YEAR=2022");

			// 2. 식중독 원인시설별 현황
			URL url2 = new URL(
					"http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2849/json/0/500/OCCRNC_YEAR=2022");

			// 3. 식중독 원인물질별 현황
			URL url3 = new URL(
					"http://openapi.foodsafetykorea.go.kr/api/7f606eb8b44d4f70a344/I2850/json/0/500/OCCRNC_YEAR=2022");

			// 4. 모범 음식점 위치
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

			// 1. 식중독 지역별 현황
			JSONObject jsonObject1 = (JSONObject) jsonParser.parse(result1);
			JSONObject I2848 = (JSONObject) jsonObject1.get("I2848");
			JSONArray row1 = (JSONArray) I2848.get("row");
			List<JSONObject> regionDataList = new ArrayList<>();
			for (int i = 0; i < row1.size(); i++) {
				JSONObject regionData = (JSONObject) row1.get(i);
				regionDataList.add(regionData);
			}
			model.addAttribute("regionData", regionDataList);

			// 2. 식중독 원인시설별 현황
			JSONObject jsonObject2 = (JSONObject) jsonParser.parse(result2);
			JSONObject I2849 = (JSONObject) jsonObject2.get("I2849");
			JSONArray row2 = (JSONArray) I2849.get("row");
			List<JSONObject> locationDataList = new ArrayList<>();
			for (int i = 0; i < row2.size(); i++) {
				JSONObject locationData = (JSONObject) row2.get(i);
				locationDataList.add(locationData);
			}
			model.addAttribute("locationData", locationDataList);

//			// 3. 식중독 원인물질별 현황
//			JSONObject jsonObject3 = (JSONObject) jsonParser.parse(result3);
//			JSONObject I2850 = (JSONObject) jsonObject3.get("I2850");
//			JSONArray row3 = (JSONArray) I2850.get("row");
//			List<JSONObject> thingDataList = new ArrayList<>();
//			for (int i = 0; i < 10/* row3.size() */; i++) {
//				JSONObject thingData = (JSONObject) row3.get(i);
//				thingDataList.add(thingData);
//				// System.out.println("thingData : " + thingData);
//			}
//			model.addAttribute("thingData", thingDataList);

			// 4. 음식점 리스트1
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

		return "/recipe/main";
	}
	
	
//	JSONParser jsonParser = new JSONParser();
//	JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
//	JSONObject message = (JSONObject) jsonObject.get("message");
//	//JSONObject result1 = (JSONObject) jsonObject.get("result");
//	JSONArray jsonResult = (JSONArray) message.get("result");
//	List<JSONObject> jsonResultList = new ArrayList<>();
//	for (int i = 0; i < jsonResult.size(); i++) {
//		JSONObject jsonResultData = (JSONObject) jsonResult.get(i);
//		jsonResultList.add(jsonResultData);
//		System.out.println(jsonResultList);
//	}
	
	
	//model.addAttribute("english", english);
	//System.out.println("english : " + english);
	//model.addAttribute("english" , english);

//	@GetMapping("main")
//	// 이미지를 화면에 보여줍니다
//	public ResponseEntity<byte[]> display(String fileName) {
//		
//		try {
//			// 파일 객체를 생성
//			File file = new File(ATTACHES_DIR + fileName);
//			HttpHeaders headers = new HttpHeaders();
//			
//			// 이미지 파일이 존재하면 파일을 이미지를 다운로드
//			if(file.exists()) {
//				// Mime타입을 설정
//				headers.add("Content-Type",Files.probeContentType(file.toPath()));
//				return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
//			}else {
//				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//			}
//			
//		} catch (IOException e) {
//			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
	
	@RequestMapping("english")
	@ResponseBody
	public String english(@RequestParam(value = "korean", defaultValue = "-") String korean, Model model)
			throws Exception {
		MainVO vo = new MainVO();
		vo.setKorean(korean);
		String english = mainservice.getenglish(vo); // 서비스에서 일을 진행 할 예정
		System.out.println("english : " + english);
		return english;
	}
}
