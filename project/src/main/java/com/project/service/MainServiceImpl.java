package com.project.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MainMapper;
import com.project.vo.MainVO;

@Service
//@Cacheable(value="getRecipe", key="#menumap")
public class MainServiceImpl implements MainService{
	
	private String clientId = "GfNnJRl8DiR6R50DdW9H";
	private String clientSecret = "rxkdB7OU9T";
	
	@Autowired
	MainMapper mainMapper;
	
	//1. 최다 추천 레시피 리스트 불러오기
	@Override
	public List<MainVO> getBoomUpList() {
		// TODO Auto-generated method stub
		return mainMapper.getBoomUpList();
	}
	
	//2. 최다 조회 레시피 리스트 불러오기
	@Override
	public List<MainVO> getViewCntList() {
		// TODO Auto-generated method stub
		return mainMapper.getViewCntList();
	}
	
	//3. 최다 댓글 레시피 리스트 불러오기
	@Override
	public List<MainVO> getReplyCntList() {
		// TODO Auto-generated method stub
		return mainMapper.getReplyCntList();
	}
	
	//4. 최근 등록 레시피 리스트 불러오기
	@Override
	public List<MainVO> getRecentList() {
		// TODO Auto-generated method stub
		return mainMapper.getRecentList();
	}
	
	//5. 영어 가져오기
	@Override
	public String getenglish(MainVO vo) {
		String korean = vo.getKorean();
		String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
		String text;
		String result = "";
		String line = "";
		try {
			text = URLEncoder.encode(korean, "UTF-8");
			String param = "source=ko&target=en&text=" + text;
			URL url = new URL(apiURL);
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setUseCaches(false);
			con.setDefaultUseCaches(false);

			OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream());
			osw.write(param);
			osw.flush();

			System.out.println("TEXT : " + text);
			
			int responseCode = con.getResponseCode();
			result += "responseCode  : " + responseCode;
			result += "\n";
            // 200코드가 아니면 오류인데 무엇이 오류 인지 디버깅 
			if (responseCode != 200) {
				Map<String, List<String>> map = con.getRequestProperties();
				result += "Printing Response Header...\n";
				for (Map.Entry<String, List<String>> entry : map.entrySet()) {
					if (entry.getKey().equals("apikey")) {
						result += "";
					} else {
						result += "Key : " + entry.getKey() + " ,Value : " + entry.getValue();
					}
				}
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			line = br.readLine();
			System.out.println("line : " + line);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(line);

			JSONObject message = (JSONObject) jsonObject.get("message");
			JSONArray resultArray = (JSONArray) message.get("result");

			List<JSONObject> jsonResultList = new ArrayList<>();
			for (Object resultObject : resultArray) {
			    JSONObject result1 = (JSONObject) resultObject;
			    String srcLangType = (String) result1.get("srcLangType");
			    String tarLangType = (String) result1.get("tarLangType");
			    String translatedText = (String) result1.get("translatedText");
			    String engineType = (String) result1.get("engineType");

			    System.out.println("translatedText : " + translatedText);

			    jsonResultList.add(result1);
			}
			
			System.out.println("jsonResultList : " + jsonResultList);
			
			/*
			 * JSONParser jsonParser = new JSONParser(); JSONObject jsonObject =
			 * (JSONObject) jsonParser.parse(line); JSONObject message = (JSONObject)
			 * jsonObject.get("message"); JSONArray jsonResult = (JSONArray)
			 * message.get("result");
			 * 
			 * System.out.println("jsonResult : " + jsonResult);
			 * 
			 * List<JSONObject> jsonResultList = new ArrayList<>(); for (int i = 0; i <
			 * jsonResult.size(); i++) { JSONObject jsonResultData = (JSONObject)
			 * jsonResult.get(i); jsonResultList.add(jsonResultData);
			 * System.out.println(jsonResultList); } result += jsonResultList + "\n";
			 * System.out.println("result : " + result);
			 */
			
			
			// 여긴 출력 
//			while ((line = br.readLine()) != null) {
//				result += line + "\n";
//				JSONParser jsonParser = new JSONParser();
//				JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
//				JSONObject message = (JSONObject) jsonObject.get("message");
//				//JSONObject result1 = (JSONObject) jsonObject.get("result");
//				JSONArray jsonResult = (JSONArray) message.get("result");
//				List<JSONObject> jsonResultList = new ArrayList<>();
//				for (int i = 0; i < jsonResult.size(); i++) {
//					JSONObject jsonResultData = (JSONObject) jsonResult.get(i);
//					jsonResultList.add(jsonResultData);
//					System.out.println(jsonResultList);
//				}
//			}
			br.close();
			
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("인코딩 실패", e);
		} catch (IOException e) {
			result = e.getMessage();
		} 
//		catch (ParseException e) {
//			e.printStackTrace();
//		}
 catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return result;
	}

	/*
	 * @Override public List<MainVO> getBoomUpListIMG() { return
	 * mainMapper.getBoomUpListIMG(); }
	 */
}
