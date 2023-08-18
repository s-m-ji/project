package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.CateService2;
import com.project.service.FileuploadService;
import com.project.service.RecBoardService2;
import com.project.service.RecFileService2;
import com.project.service.RecMatService2;
import com.project.service.RecStepService2;
import com.project.service.RecipeService;
import com.project.vo.CategoryVO2;
import com.project.vo.Criteria;
import com.project.vo.FileuploadVo;
import com.project.vo.IngredientsVo;
import com.project.vo.LikeVo;
import com.project.vo.MaterialVo;
import com.project.vo.MemberVo;
import com.project.vo.PageDto;
import com.project.vo.RecBoardVO2;
import com.project.vo.RecMatVO2;
import com.project.vo.RecStepVO2;
import com.project.vo.RecipeBoardVo;
import com.project.vo.RecipeReplyVo;
import com.project.vo.RecipeStepVo;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/recipe/*")
@Log4j
public class RecipeController {

	@Autowired
	RecipeService service;
	
	
	
	/**
	 * 레시피 리스트에서 항목 클릭 시 상세 페이지로 이동 될 수 있도록 매핑
	 * list 에서 항목을 클릭하면 b_no 를 파라메터로 수집하여 
	 * b_no 을 활용해 테이블에서 게시글에대한 정보를 조회한다.
	 * 
	 * 	model 을 사용해 view 페이지에 데이터를 넘겨 줄 수 있도록 한다.
	 * 
	 * 
	 * @param model
	 * @param paramVo
	 */
	@GetMapping("view")
	public void RecipeView(Model model
						, RecipeBoardVo paramVo) {

		// 파라메터로 수집한 bno 를 변수에 저장 
		int b_no = paramVo.getB_no();
		
		// 데이터가 잘 넘어왔는지 확인
		log.info("============== bno " + b_no); 
		
		// b_no 를 활용해 데이터 베이스에서 게시글 정보 조회 // 우선 2으로 설정 해둠 수정해야함
		RecipeBoardVo vo =  service.getOne(b_no);
		
		// 객체 정보가 넘어온다..
		//service.getMaterial(2);
		
		
		// 재료 정보 조회

		int replyCnt =service.replyTotalCnt(b_no);
		int photoReviewCnt = service.photoTotalCnt(b_no);
		// key, value 로 이루어진 model 객체를 사용해 /recipe/view 페이지에 데이터 전달.
		model.addAttribute("replyCnt", replyCnt);
		model.addAttribute("photoReviewCnt", photoReviewCnt);
		model.addAttribute("board", vo);
		
		
	}
	
	//////////////////////////////////////////////////////////////////  동준  //////////////////////////////////////
	
	
	@GetMapping("/listTest")
	public String listTest1() {
		return"/recipe/list_test";
	}
	
	
	@Autowired
	RecBoardService2 recservice;
	
	@Autowired
	CateService2 cateservice;
	
	
	@Autowired
	RecMatService2 matservice;
	
	@Autowired
	RecStepService2 stepservice;
	
	@GetMapping("/list2")
	public String listTest() {
		System.out.println("리스트페이지 테스트");
		return "/recipe/rec_list";
	}
	
	@GetMapping("/rec_write")
	public String recWrite(Model model, HttpSession session) {
		
		MemberVo member = session.getAttribute("member") == null ? null : (MemberVo)session.getAttribute("member") ;
		
		if(member == null) {
			model.addAttribute("message","false");
			return "/recipe/login";
		}
		
		model.addAttribute("mno",member.getMno());
		model.addAttribute("nickName",member.getNickname()); 
		
		return "/recipe/rec_write";
	}
	
	@PostMapping("/postWrite")
    public String postWrite(RecBoardVO2 recBoardVO
    						,RecMatVO2 matvo ,RecStepVO2 stepvo
    						 ,String[] I_NAME, String [] materialCnt 
    						 ,String[] step_content
    						, @RequestParam("photos") List<MultipartFile> photos
    						, @RequestParam("Fphotos") List<MultipartFile> Fphotos
    						, @RequestParam("Sphotos") List<MultipartFile> Sphotos
    						, Model model) {
		
		
		try {
			// rec_board에 레시피 정보 등록
			
        	System.out.println("c_no 1 : " + recBoardVO.getC_no1());
        	System.out.println("c_no 2 : " + recBoardVO.getC_no2());
            int res = recservice.insertSelectKey(recBoardVO, photos, Fphotos, Sphotos, model);
            
            
            
            int B_NO = recBoardVO.getB_NO();
            
            //int res2 =  recservice.FinishFiles(Fphotos);
			 
              int res3 = 0;
			  int res4 = 0;
			  
		for(int i = 0; i < I_NAME.length; i++) {
			
			
			matvo.setI_NAME(I_NAME[i]);
			matvo.setMaterialCnt(materialCnt[i]);
			matvo.setB_NO(B_NO);
			
			
			res3 = matservice.insert(matvo);
			
			System.out.println("안 ==========================");
		}
			System.out.println("밖 ==========================");
		
			
		for(int i = 0; i < step_content.length; i++) {
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~ 실행전");
			
			System.out.println(step_content[i]);
			
			stepvo.setStep_content(step_content[i]);
			stepvo.setB_NO(B_NO);
			
			res4 = stepservice.insert(stepvo);
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~ 실행후");
			
		}
			stepservice.minusStep(B_NO);
            
            
            
            if (res > 0 && res3>0 && res4>0) {
                
                
                String msg = recBoardVO.getB_NO() + "번 등록되었습니다";	
                model.addAttribute("msg", msg);
                return "redirect:/recipe/list";
            } else {
                String msg = "등록 중 예외사항이 발생하였습니다.11";
                model.addAttribute("msg", msg);
                return "/recipe/message";
            }
        
		} catch (Exception e) {
            String msg = "등록 중 예외사항이 발생하였습니다.22";
            System.out.println(e.getMessage());
            model.addAttribute("msg", msg);
            return "/recipe/message";
        }
    }
	
	
//////////////////////////////////////////////////////////////// 동준 //////////////////////////////////////
	
	
	
	@Autowired
	FileuploadService fileService;
	

	
	@GetMapping("material/{bno}")
	public @ResponseBody Map<String, Object> getMaterial(@PathVariable("bno") int bno){
		
		System.out.println(" getMaterial 호출 ========================================== ");
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<MaterialVo> material = service.getMaterial(bno);
		
		map.put("materialList", material);
		
		return map;
		
	}
	
	@GetMapping("recipeStep/{bno}")
	public @ResponseBody Map<String,Object> getRecipeStep(@PathVariable("bno") int bno){
		
		
		System.out.println(" getRecipeStep 호출 ========================================== ");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<RecipeStepVo> step = service.getRecipeStep(bno);
		List<FileuploadVo> stepFile = fileService.getRecipeStep(bno);
		List<FileuploadVo> finishImgs = fileService.getFinishImg(bno);
		
		map.put("recipeStep", step);
		map.put("fileStepList", stepFile);
		map.put("finishImgs", finishImgs);
		
		return map;
	}
	
	
	@GetMapping("replyList/{bno}")
	public @ResponseBody Map<String,Object> getRecipeList(@PathVariable("bno") int bno){
		
		
		System.out.println(" getRecipeList 호출 ========================================== ");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<RecipeReplyVo> replyList = service.getRecipeReply(bno);
		
		map.put("replyList", replyList);
		map.put("photoReview", fileService.getPhotoReview(bno));
		
		return map;
	}
	
	
	@GetMapping("/modal/ingredientModal/{i_no}/{i_name}")
	public @ResponseBody Map<String, Object> getIngredient(@PathVariable("i_name") String i_name
															, @PathVariable("i_no") int i_no){
		
		System.out.println("getIngredient 호출 ==========================================");
		
		System.out.println("i_name : " + i_name);
		System.out.println("i_no : " + i_no);
		
		Map<String, Object> map = new HashMap<String, Object>();
		IngredientsVo ingredient = service.getIngredients(i_name);
		FileuploadVo ingredientImg = fileService.getIngredients(i_no);
		
		map.put("ingredient", ingredient);
		map.put("ingredientImg", ingredientImg);
		
		return map;
	}
	
	
	@PostMapping("likeRecipe")
	public @ResponseBody Map<String, Object> likeRecipe(@RequestBody LikeVo vo){
		
		System.out.println("likeRecipe 성공 ======================");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("likeRecipe 성공 ========================================");
		
		System.out.println("b_no : " +vo.getB_no());
		System.out.println("mno : " + vo.getMno());
		
		
		
			try {

				int res = service.like_Recipe(vo);
				map.put("message", "레시피 저장 성공  ! ");
				map.put("res",res);
				log.info(res);
		
			} catch (Exception e) {
			
				map.put("message","이미 저장 되어 있는 레시피 입니다 . ^^");
				map.put("res", 0);// TODO: handle exception
				
			}
				
		
		return map;
	}
	
	@GetMapping("plusView/{b_no}")
	public @ResponseBody Map<String, Object> plusViewCnt(@PathVariable("b_no") int b_no){
		
		System.out.println("plusView 실행 ==============================================");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int res = service.plusViewcnt(b_no);
		
		if(res > 0) {
		
			map.put("res", res);
			
		}else {
			
			map.put("res", res);
		}
		
		
		return map;
	
	}
	
	/* ========================================================================================== */
	
	// 나의 정보
	@GetMapping("myPage2")
	public String myPage(Model model, HttpSession session) {
		
		try {
			
			
			MemberVo member = session.getAttribute("member") == null ? null : (MemberVo)session.getAttribute("member") ;
			
			if(member == null) {
				model.addAttribute("message","false");
				return "/recipe/login";
			}
			
			int m_no = member.getMno();
			
			System.out.println("myPage member : " + member);
			System.out.println("myPage mno : " + m_no);
			
			FileuploadVo FileVo = fileService.getMemberImg(m_no);
			
			String savePath = FileVo.getSavePath();
			savePath = savePath.replace("\\", "/");
			/*
			if(member == null) {
				System.out.println("로그인이 필요합니다.");
				return "/recipe/login";
						
			}else {
				System.out.println("로그인 되어 있습니다. 저장 정보를 jsp 에 출력할 수 있습니다. =================================================");
				model.addAttribute("member", member);
				return "/recipe/myPage";
			}
			*/
			
			// 회원정보 model 저장
			model.addAttribute("savePath", savePath);
			model.addAttribute("member", member);

		} catch (Exception e) {
			System.out.println("로그인 정보가 없거나 혹은 이미지가 없습니다.");
		}
		
				return "/recipe/myPage2";
	}
	
	
	
	
	@GetMapping("myPage_recipe")
	public void myPage_Recipe() {
	
	}
	
	
	@GetMapping("myPage_recipeList/{m_no}")
	public @ResponseBody Map<String, Object> myPage_Recipe(@PathVariable("m_no") int m_no) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<RecipeBoardVo> list =  service.myRecipe(m_no);
		
		map.put("list", list);
		
		return map;
	}
	
	// 레시피리스트 출력
	@GetMapping("myList")
	public String myPage_mode(HttpSession session, Model model, @RequestParam("mode") String mode){
	    
	    // 세션에서 받아오기
	    
	    System.out.println("mode 출력 ============================== "+ mode);
	    
	    try {
	        
	    	// 로그인 하지 않으면 오류가 발생하면서 안됨...
	        MemberVo member = session.getAttribute("member") == null ? null : (MemberVo)session.getAttribute("member") ;
	        int m_no = member.getMno();
	        
	        if ("myRecipe".equals(mode)) { // 문자열 비교 수정
	            System.out.println("마이 레시피 출력 ===================================");
	            List<RecipeBoardVo> list =  service.myRecipe(m_no);
	            System.out.println(list);
	            
	            for(RecipeBoardVo myR : list) {
	            	System.out.println("경로 출력 =============" + myR.getSavePath());
	            	String sP = myR.getSavePath().replace("\\", "/");
	            	myR.setSavePath(sP);
	            	System.out.println("변경 출력 =============" + myR.getSavePath());
	            }
	            
	            model.addAttribute("myList", list);
	            
	            
	        } else if ("myLike".equals(mode)) { // 문자열 비교 수정
	            System.out.println("찜한 레시피 출력 ===================================");
	            List<RecipeBoardVo> list =  service.getLikeRecipeList(m_no);
	            System.out.println(list);
	            
	            for(RecipeBoardVo myR : list) {
	            	System.out.println("경로 출력 =============" + myR.getSavePath());
	            	String sP = myR.getSavePath().replace("\\", "/");
	            	myR.setSavePath(sP);
	            	System.out.println("변경 출력 =============" + myR.getSavePath());
	            }
	            
	            model.addAttribute("myList", list);            
	        }
	    
	    } catch (Exception e) {
	        // TODO: handle exception
	    }
	    
	    return "/recipe/myPage_recipe";
	}
	
	@GetMapping("myPage_Review")
	public void myReview(Model model, HttpSession session,@RequestParam("mode") String mode, Criteria cri) {
		
		try {
			
			// 로그인 하지 않으면 오류가 발생하면서 안됨...
	        MemberVo member = session.getAttribute("member") == null ? null : (MemberVo)session.getAttribute("member") ;
	        int m_no = member.getMno();
	        String nickName = member.getNickname();
			
			if("myWrite".equals(mode)) {
				
				List<RecipeReplyVo> ReviewList =  service.getMyReply(nickName);
				System.out.println("내가 쓴 후기  출력 ===========================" + ReviewList);
				 
				for(RecipeReplyVo myR : ReviewList) {
					  System.out.println("경로 출력 =============" + myR.getSavePath()); 
					  String sP = myR.getSavePath().replace("\\", "/"); 
					  myR.setSavePath(sP);
					  System.out.println("변경 출력 =============" + myR.getSavePath()); 
					  }
				
				model.addAttribute("ReviewList", ReviewList);
				
			}else if("myReceive".equals(mode)) {
				
				if(cri.getAmount() == 10) {
					cri.setAmount(5);
				} else {
					cri.setAmount(cri.getAmount());
				}
				
				cri.setPageNo(cri.getPageNo());
				
				System.out.println("스타트 넘버 ==================="+ cri.getStartNo());
				System.out.println("스타트 넘버 ==================="+ cri.getEndNo());
				
				List<RecipeReplyVo> ReviewList = service.getReceiveReply(m_no, cri);
				System.out.println("내가 받은 후기  출력 ===========================" + ReviewList);

				
				
				  for(RecipeReplyVo myR : ReviewList) {
				  System.out.println("경로 출력 =============" + myR.getSavePath()); 
				  String sP = myR.getSavePath().replace("\\", "/"); 
				  myR.setSavePath(sP);
				  System.out.println("변경 출력 =============" + myR.getSavePath()); 
				  }
				 
				
				int totalCnt = service.getTotalRecieveReply(1); 
				System.out.println("totalCnt : "  + totalCnt);
				
				PageDto pageDto = new PageDto(cri, totalCnt);
				System.out.println("pageDto : "  + pageDto);
				
				model.addAttribute("tCnt", totalCnt); 
				model.addAttribute("pDto", pageDto);
				
				model.addAttribute("ReviewList", ReviewList);
			}
		
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
			System.out.println(e.getMessage());
			System.out.println("오류나요~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		}
		
		
		
	}
	
	
	
}
