package com.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.project.vo.FileuploadVo;
import com.project.vo.IngredientsVo;
import com.project.vo.LikeVo;
import com.project.vo.MaterialVo;
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
	public String recWrite() {
		
		
		
		return "/recipe/rec_write";
	}
	
	@PostMapping("/postWrite")
    public String postWrite(RecBoardVO2 recBoardVO
    						, RecMatVO2 matvo, RecStepVO2 stepvo 
    						,  @RequestParam("photos") List<MultipartFile> photos
    						, Model model) {
        try {
            // rec_board에 레시피 정보 등록
        	System.out.println("c_no 1 : " + recBoardVO.getC_no1());
        	System.out.println("c_no 2 : " + recBoardVO.getC_no2());
            int res = recservice.insertSelectKey(recBoardVO, photos);
           
            int res3 = matservice.insert(matvo);
            int res4 = stepservice.insert(stepvo);
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
		
		try {
	
			int res = service.like_Recipe(vo);
			
			
				
				map.put("message", "레시피 저장 성공  ! ");
			
			
			
			log.info(res);
		
		} catch (Exception e) {
			map.put("message","이미 저장 되어 있는 레시피 입니다 . ^^");
		}
	
		
		
		
		
		return map;
	}
	
	
}
