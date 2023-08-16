package com.project.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.mapper.MemberMapper;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;
import com.project.vo.PageDto;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	@Autowired
	AdminFileService adminfileservice;
	
	 // 회원 목록 조회 (검색조건 + 페이징)
	@Override
	public List<MemberVo> memberList(Criteria cri, Model model) {
			/* 페이지 게시물 개수 처리 */
		cri.setAmount(5);
		cri.setPageNo(cri.getPageNo());
		
		List<MemberVo> list = membermapper.memberList(cri);
		int totalCnt = membermapper.getTotalCnt(cri);
		PageDto pageDtoA = new PageDto(cri, totalCnt);
		
		model.addAttribute("list", list);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageDtoA", pageDtoA);
		
		return null;
	}
	
	// 회원 총 건수 조회
	@Override
	public int getTotalCnt(Criteria cri) {
		return membermapper.getTotalCnt(cri);
	}
	
	// 탈퇴 회원 선택 삭제
	@Override
	public int delMem(String mno, String delyn) {
		return membermapper.delMem(mno, delyn);
	}

	// 회원 등록 + 파일 등록 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int adminInput(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception {
		int res = membermapper.adminInput(membervo);
		
		adminfileservice.fileupload(files, membervo.getMno());
		
		return res;
	}
	
	// 회원 한 건 불러오기 
	@Override
	public MemberVo getMemOne(int mno) {
		return membermapper.getMemOne(mno);
	}
	
	// 회원 수정하기 + 파일 수정 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int memberUpdate(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception {
		int res = membermapper.memberUpdate(membervo);
		adminfileservice.fileupload(files, membervo.getMno());
		return res;
	}

	
	// 공지 목록 조회
	@Override
	public List<NoticeVo> noticeList(Criteria cri,Model model) {
		/* 페이지 게시물 개수 처리 */
		cri.setAmount(6);
		cri.setPageNo(cri.getPageNo());
		
		List<NoticeVo> notList = membermapper.noticeList(cri);
		int totalNcnt = membermapper.getTotalNcnt(cri);
		PageDto pageDtoN = new PageDto(cri, totalNcnt);
		
		model.addAttribute("notList", notList);
		model.addAttribute("totalNcnt", totalNcnt);
		model.addAttribute("pageDtoN", pageDtoN);
		
		return null;
	}
	// 공지 글 등록
	@Override
	public int noticeWrite(NoticeVo noticevo) {
		int res = membermapper.noticeWrite(noticevo);
		return res;
	}

	// 공지 총 건수 
	@Override
	public int getTotalNcnt(Criteria cri) {
		return membermapper.getTotalNcnt(cri);
	}
	
	// 공지 한 건
	@Override
	public NoticeVo noticeOne(int nno) {
		return membermapper.noticeOne(nno);
	}
	// 공지 삭제 
	@Override
	public int noticeDel(int nno) {
		return membermapper.noticeDel(nno);
	}
	
	// 공지 수정 
	@Override
	public int noticeUpdate(NoticeVo noticevo) {
		int res = membermapper.noticeUpdate(noticevo);
		return res;
	}
	
	// 리워드 조회 
	@Override
	public List<MemberVo> rewardList(String startDate, String endDate) {
		return membermapper.rewardList(startDate, endDate);
	}

	// 리워드 수정 
	@Override
	public int gradeUpdate(MemberVo membervo) {
		return membermapper.gradeUpdate(membervo);
	}

	@Override
	public List<MemberVo> rewardListReal(Model model) {
		List<MemberVo> rewardListReal = membermapper.rewardListReal();
		model.addAttribute("rewardListReal", rewardListReal);
		return null;
	}

	// 마이페이지 회원 탈퇴 
	@Override
	public int myPageDel(int mno) {
		int res = membermapper.myPageDel(mno);
		return res;
	}

	


	
	
	// 광민
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Autowired
	MailService mailservice;
	
	@Override
	public MemberVo login(MemberVo paramMember) {
		MemberVo member = membermapper.login(paramMember);
		if(member != null) {
			// 사용자가 입력한 비밀번호가 일치하는지 확인
			// 사용자가 입력한 비밀번호, 데이터베이스에 암호화되어 저장된 비밀번호
			boolean res = 
					encoder.matches(paramMember.getPw()
									, member.getPw());
			 List<String> role = membermapper.getMemberRole(member.getEmail());
			// 비밀번호 인증이 성공하면 member객체를 반환
			if(res) {
				member.setRole(role);
			return member;
			}else {
				
				return null;
			}
		}
		return membermapper.login(member);
	}
	
	@Override
	public int insert(MemberVo member) {
		
		BCryptPasswordEncoder encoder 
						= new BCryptPasswordEncoder();
		
		// 비밀번호 암호화
		member.setPw(encoder.encode(member.getPw()));
		System.out.println("pw : " + member.getPw());
		return membermapper.insert(member);
	}

	@Override
	public int emailCheck(MemberVo member) {
		return membermapper.emailCheck(member);
	}
	
	@Override
	public int nicknameCheck(MemberVo member) {
		return membermapper.nicknameCheck(member);
	}
	
	@Override
	public String findEmailBy(MemberVo member) {
		return membermapper.findEmailBy(member);
	}
	
	@Override
	public String sendPwBy(MemberVo member, Model model) {
		String pw = membermapper.sendPwBy(member);
		System.out.println("pw : " + pw);
		if (pw != null) {
			// 임시 비밀번호 생성
			String temporaryPassword = PasswordGenerator.generateRandomPassword();

	        // 사용자 비밀번호 업데이트 (생성한 임시 비밀번호로 업데이트)
	        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	        String encodedTemporaryPassword = passwordEncoder.encode(temporaryPassword);
	        membermapper.updatePassword(member.getEmail(), encodedTemporaryPassword);

			// 이메일 전송
	        member.setPw(temporaryPassword);
    		mailservice.findMailSend(member);
    		System.out.println(pw);
    		model.addAttribute("msg", "해당 이메일로 임시비밀번호가 발송되었습니다.");
    		return "recipe/send-pw-form";
    		
    	} else {
    		model.addAttribute("error", "해당 아이디와 이름으로 등록된 정보가 없습니다.");
    		return "recipe/send-pw-form";
    	}
	}

	@Override
	public boolean emailExists(String email) {
		return membermapper.emailExists(email);
	}
	
	@Autowired
	ApiExamMemberProfile apiExam;
	
	@Override
	public void naverLogin(HttpServletRequest request, Model model) {
		try {
			// callback처리 -> access_token
			Map<String, String> callbackRes = callback(request);
			
			String access_token = callbackRes.get("access_token");
			// access_token -> 사용자 정보 조회
			Map<String, Object> responseBody 
							= apiExam.getMemberProfile(access_token);
			
			Map<String, String> response 
					= (Map<String, String>) responseBody.get("response");
			System.out.println("================ naverLogin ");
			System.out.println(response.get("name"));
			System.out.println(response.get("id"));
			System.out.println(response.get("gender"));
			System.out.println("=============================");
			
			// 세션에 저장
			model.addAttribute("id", response.get("id"));
			model.addAttribute("name", response.get("name"));
			model.addAttribute("genter", response.get("gender"));
			
		} catch (Exception e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public Map<String, String> callback(HttpServletRequest request) throws Exception{
	    String clientId = "K4dBcaR2392POv2SFnSD";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "npOaEFGzxk";//애플리케이션 클라이언트 시크릿값";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    try {
	    String redirectURI = URLEncoder.encode("http://localhost:8080/login/naver_callback", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    String access_token = "";
	    String refresh_token = "";
	    System.out.println("apiURL="+apiURL);
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      if(responseCode==200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	        System.out.println("token요청" + res.toString());
	        // json문자열을 Map으로 변환
	    	Map<String, String> map = new HashMap<String, String>();
	  		ObjectMapper objectMapper = new ObjectMapper();
	  		map = objectMapper.readValue(res.toString(), Map.class);
	  		return map;
	      } else {
	    	  throw new Exception("callback 반환코드 : " + responseCode);
	      }
	    } catch (Exception e) {
	      System.out.println(e);
	      throw new Exception("callback 처리중 예외사항이 발생 하였습니다. ");
	    }
	}
	
	public String getToken(String code) throws IOException {
        // 인가코드로 토큰받기
        String host = "https://kauth.kakao.com/oauth/token";
        URL url = new URL(host);
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
        String token = "";
        try {
            urlConnection.setRequestMethod("POST");
            urlConnection.setDoOutput(true); // 데이터 기록 알려주기

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=a88f9343e17d11ccbc54e79106cac137");
            sb.append("&redirect_uri=http://localhost:8080/recipe/list");
            sb.append("&code=" + code);

            bw.write(sb.toString());
            bw.flush();

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("result = " + result);

            // json parsing
            JSONParser parser = new JSONParser();
            JSONObject elem = (JSONObject) parser.parse(result);

            String access_token = elem.get("access_token").toString();
            String refresh_token = elem.get("refresh_token").toString();
            System.out.println("refresh_token = " + refresh_token);
            System.out.println("access_token = " + access_token);

            token = access_token;

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (org.json.simple.parser.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


        return token;
    }


    public Map<String, Object> getUserInfo(String access_token) throws IOException {
        String host = "https://kapi.kakao.com/v2/user/me";
        Map<String, Object> result = new HashMap<>();
        try {
            URL url = new URL(host);

            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestProperty("Authorization", "Bearer " + access_token);
            urlConnection.setRequestMethod("GET");

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);


            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            String line = "";
            String res = "";
            while((line=br.readLine())!=null)
            {
                res+=line;
            }

            System.out.println("res = " + res);


            JSONParser parser = new JSONParser();
            JSONObject obj = (JSONObject) parser.parse(res);
            JSONObject kakao_account = (JSONObject) obj.get("kakao_account");
            JSONObject properties = (JSONObject) obj.get("properties");


            String id = obj.get("id").toString();
            String nickname = properties.get("nickname").toString();
            String age_range = kakao_account.get("age_range").toString();

            result.put("id", id);
            result.put("nickname", nickname);
            result.put("age_range", age_range);

            br.close();


        } catch (IOException e) {
            e.printStackTrace();
        } catch (org.json.simple.parser.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return result;
    }

    public String getAgreementInfo(String access_token)
    {
        String result = "";
        String host = "https://kapi.kakao.com/v2/user/scopes";
        try{
            URL url = new URL(host);
            HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.setRequestProperty("Authorization", "Bearer "+access_token);

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            String line = "";
            while((line=br.readLine())!=null)
            {
                result+=line;
            }

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            // result is json format
            br.close();

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


}
