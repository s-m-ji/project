	package com.project.controller;

import java.awt.PageAttributes.MediaType;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.service.ComBoardService;
import com.project.service.ComFileService;
import com.project.service.ComReplyService;
import com.project.vo.ComBoardVO;
import com.project.vo.ComFileVO;
import com.project.vo.ComReplyVO;
import com.project.vo.RecipeReplyVo;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/comboard/*")
@Log4j
public class ComBoardController {

	public static final String ATTACHES_DIR = "c:\\upload\\";
	
	
	@Autowired
	ComBoardService service;
	
	 @Autowired
	ComReplyService replyService;
	 
	 @Autowired
	 ComFileService fileservice;
	
	// test
	 @GetMapping("/test")
	 public String test() {
		 return "/recipe/test";
	 }
	 
	 
	 
	 
	// 리스트 페이지 ------------------------------------------------
	@GetMapping("/list")
	public String getlist(Model model) {
	    List<ComBoardVO> list = service.getlist(model);
	    model.addAttribute("list", list);
	    
	    return "/recipe/com_list2";
	}
	
	@PostMapping("/postList")
	public String getlist2(Model model) {
	    List<ComBoardVO> list = service.getlist(model);
	    model.addAttribute("list", list);
	    
	    return "/recipe/com_list2";
	}
	
	
	// 글쓰기 페이지  -------------------------------------------------
	
	@GetMapping("/write")
	public String writepage() {
		
		return "/recipe/com_write";
	}
	
	
	// 글쓰기 등록  -------------------------------------------------
	
	@PostMapping("/comWriteAction")
	public String comWriteAction(ComBoardVO board,
	                             @RequestParam("photos") List<MultipartFile> photos,
	                             Model model, RedirectAttributes rttr) {
	    try {
	        // 게시물 등록
	        int res = service.insertSelectKey(board, photos);

	        if (res > 0) {
	            // 등록 성공 시 처리
	            System.err.println("성공=================");
	            rttr.addFlashAttribute("msg", "게시물이 성공적으로 등록되었습니다.");
	            // 게시물 등록 후 해당 게시물의 번호를 파라미터로 전달하여 com_list로 리다이렉트
	            return "redirect:/recipe/com_list";
	        } else {
	            // 등록 실패 시 처리
	            System.err.println("실패==================");
	            model.addAttribute("msg", "게시물 등록에 실패하였습니다.");
	            return "/comboard/com_list2";
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        System.err.println("예외 ==================");
	        log.error(e.getMessage());
	        model.addAttribute("msg", "등록 중 예외가 발생하였습니다.");
	        return "/comboard/com_list2";
	    }
	}
	
		// 이미지 불러오기 (왜안되지);;
	
	
	@GetMapping("/comFile")
	public ResponseEntity<byte[]> display(String filename) {
	    log.info("=====fileName : " + filename);

	    try {
	        // 파일 객체를 생성
	        File file = new File(ATTACHES_DIR + filename);
	        HttpHeaders headers = new HttpHeaders();

	        // 이미지 파일이 존재하면 파일을 이미지를 다운로드
	        if (file.exists()) {
	            // Mime타입을 설정
	            headers.add("Content-Type", Files.probeContentType(file.toPath()));
	            return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	        }

	    } catch (IOException e) {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	
	@RequestMapping("/comboard/view/{com_bno}")
	public String view2(@PathVariable int com_bno, Model model) {
	    // comFileVO 객체를 생성하고 값을 설정 (예시)
	    ComFileVO comFileVO = new ComFileVO();
	    comFileVO.setFilename("example.jpg");

	    // board라는 이름으로 comFileVO 객체를 JSP 페이지로 전달
	    model.addAttribute("comFile", comFileVO);
	    System.out.println("-------------------- comFileVO : "  + comFileVO);

	    return "com_view";
	}
	   

	
	
	
	
	
	
	
	
	// 상세보기 페이지 + 댓글  -------------------------------------------------
	
	@GetMapping("/view")
	public String viewBoard(@RequestParam("com_bno") int com_bno, Model model) {
	    // 게시글 정보 조회
	    ComBoardVO board = service.getOne(com_bno);
	    model.addAttribute("board", board);

	    // ComFileVO 객체들 가져오기 (여러 개의 사진을 가져올 수 있으므로 List로 저장)
	    List<ComFileVO> fileList = fileservice.getList(com_bno);
	    model.addAttribute("fileList", fileList);
	    
	    ComFileVO comFile = fileservice.getOne(com_bno);
	    String fileName = comFile.getSavePath().replace("\\", "/");
	    comFile.setSavePath(fileName);
	    
	    model.addAttribute("comFile", comFile);
	    
	    System.out.println(" -------------------- fileList : " + fileList);
	    System.out.println(" -------------------- comFile : " + comFile);

	    // 내가 작성한 댓글 목록 조회
	    List<ComReplyVO> myReplies = replyService.getMyReplies(com_bno);
	    if (myReplies == null) {
	        myReplies = new ArrayList<ComReplyVO>(); // 댓글이 없는 경우 빈 리스트로 초기화
	    }
	    model.addAttribute("myReplies", myReplies);

	    return "/recipe/com_view";
	}
	
	
	
	// 상세보기 게시글 삭제  -------------------------------------------------
	
	
		@PostMapping("delete")
		public String delete(@RequestParam("com_bno") int bno, RedirectAttributes rttr) {
		    int res = service.delete(bno);
		    if (res > 0) {
		        rttr.addFlashAttribute("msg", "삭제되었습니다.");
		    } else {
		        rttr.addFlashAttribute("msg", "삭제중 예외가 발생하였습니다.");
		    }
		    return "redirect:/comboard/list";
		}
		
	// 수정 페이지로 이동 ---------------------------------------------------
	
		@PostMapping("/edit")
	    public String editpage(@RequestParam("com_bno") int com_bno, Model model) {
	        ComBoardVO board = service.getOne(com_bno);
	        model.addAttribute("board", board);
	        return "/recipe/com_write";
	    }
		

    	// 수정 처리 (POST 방식)
        @PostMapping("/editAction")
        public String editAction(ComBoardVO comboard,
                                 @RequestParam("com_bno") int com_bno,
                                 @RequestParam("photos") List<MultipartFile> photos,
                                 RedirectAttributes rttr,
                                 Model model) {

	            // 수정
	            int res;
	            try {
	                // 기존 게시물의 번호를 설정
	                comboard.setCom_bno(com_bno);
	                res = service.update(comboard, photos);

	                if (res > 0) {
	                    // 수정 성공 시 처리
	                    rttr.addFlashAttribute("msg", "수정되었습니다.");
	                    // 상세페이지로 이동
	                    return "redirect:/comboard/view?com_bno=" + comboard.getCom_bno();
	                } else {
	                    // 수정 실패 시 처리
	                    model.addAttribute("msg", "수정중 예외사항이 발생 하였습니다.");
	                    return "/comboard/message";
	                }
	            } catch (Exception e) {
	                // 예외 처리
	                if (e.getMessage().indexOf("첨부파일") > -1) {
	                    model.addAttribute("msg", e.getMessage());
	                } else {
	                    model.addAttribute("msg", "수정중 예외사항이 발생 하였습니다.");
	                }
	                return "/comboard/message";
	            }
	        }
	        
	        
	        // 댓글 등록 ----------------------------------------------------------------
	        
	        @PostMapping("/replyInsert")
	        @ResponseBody
	        public Map<String, Object> insert(@RequestBody ComReplyVO vo) {
	        	log.info("================= insert");
	        	log.info("replyVO" + vo);
	        	Map<String, Object> map = new HashMap<String, Object>();
	        	
	        	try {
	        		int res = replyService.insert(vo);
	        		if (res > 0) {
	        			map.put("result", "success");
	        			map.put("message", "댓글이 등록되었습니다.");
	        		} else {
	        			map.put("result", "fail");
	        			map.put("message", "댓글 등록에 실패하였습니다.");
	        		}
	        	} catch (Exception e) {
	        		map.put("result", "error");
	        		map.put("message", e.getMessage());
	        	}
	        	
	        	return map;
	        }
	        
	        
//	        // 댓글 수정 
//	        @PostMapping("/getReply")
//	        public String replyEdit(ComReplyVO vo) {
//	        	
//	        	replyService.update(vo);
//	        	
//	        	return "";
//	        }
//	        
//	        // 댓글 삭제
//	        @PostMapping("/deleteReply")
//	        public String replyDelete( @RequestParam("R_NO") int R_NO
//	        							, RedirectAttributes rttr) {
//	            int res = replyService.delete(R_NO);
//	            if (res > 0) {
//	                rttr.addFlashAttribute("msg", "댓글이 성공적으로 삭제되었습니다.");
//	            } else {
//	                rttr.addFlashAttribute("msg", "댓글 삭제 중 오류가 발생하였습니다.");
//	            }
//	            return "redirect:/comboard/list";
//	        }
	        
	        
	        
	        @PostMapping("/replyDelete/{R_NO}")
	        @ResponseBody
	        public Map<String, Object> delete(@PathVariable("R_NO") int R_NO) {
	            System.out.println("삭제  ================================");
	            Map<String, Object> map = new HashMap<String, Object>();
	            int res = replyService.delete(R_NO);
	            if (res > 0) {
	                map.put("result", "success");
	            } else {
	                map.put("result", "fail");
	            }	
	            return map;
	        }
	    	
	    	
//	    	@PostMapping("/reply/edit")
//	    	public Map<String, Object> edit(@RequestBody RecipeReplyVo vo){
//	    		
//	    		System.out.println("수정 호출호출 ================================");
//	    		
//	    		Map<String, Object> map = new HashMap<String, Object>();
//	    		
//	    		int res = replyService.update(vo);
//	    		
//	    		if(res > 0) {
//	    			
//	    			map.put("result", "success");
//	    		
//	    		}else {
//	    		
//	    			map.put("result", "fail");
//	    		}
//	    			
//	    		return map;
//	    		
//	    	}
	    	
	        
	        
	        
	        
	        
	    }
	    







	
	
	
	

