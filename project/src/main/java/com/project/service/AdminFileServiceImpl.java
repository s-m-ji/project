package com.project.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.mapper.AdminFileMapper;
import com.project.vo.AttachVO;
import com.project.vo.MemberVo;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Log4j
@Service
public class AdminFileServiceImpl implements AdminFileService{
	
	@Autowired
	AdminFileMapper adminfilemapper;
	
	public static final String ATTACHES_DIR ="c:\\upload\\";
	
	@Override
	public int fileInsert(MemberVo membervo) {
		return adminfilemapper.fileInsert(membervo);
	}

	@Override
	public List<MemberVo> fileSelect(int mno) {
		return adminfilemapper.fileSelect(mno);
	}

	@Override
	public List<MemberVo> getAllList() {
		System.out.println("AdminFileservice : getAlllist출력");
		return adminfilemapper.getAllList();
	}
	
	
	// 파일 저장 ( 경로 생성 ) 
	public String getFolder() {
		// 날짜 가져오기 
		LocalDate currentDate = LocalDate.now();
		String uploadPath = currentDate.toString().replace("-", File.separator) + File.separator;

		log.info("날짜 : " + currentDate);
		log.info("uploadPth : " + currentDate.toString().replace("-", File.separator) + File.separator );
		
		// 폴더 생성  			 C:\\upload\2023\07\18
		File saveDir = new File(ATTACHES_DIR + uploadPath);
		 // (폴더가 없으면) 
		if(!saveDir.exists()) {
			// 여러개 's' mkdir과 mkdirs 
			if(saveDir.mkdirs()) {
				log.info("완료) 폴더 생성");
			}else {
				log.info("실패) 폴더생성"); 
			}
		}
		return uploadPath;
	}
	
	
	// 공통으로 사용되는 fileUpload( upload된 결과값을 담음 )
		public int fileupload(List<MultipartFile> files, int mno) throws Exception {
			// insert한 결과를 담는다. 
			int insertRes = 0;
			
			//  files을  반복하면서  file에 저장하여 출력함 
			for(MultipartFile file : files) {
				
				// 파일이 비어있으면 밑줄 실행하지 하고 다시 올라옴
				if(file.isEmpty()) {
					continue;
				}
					log.info(" ==== 파일업로드 ====" );
					log.info("oname : " + file.getOriginalFilename());
					log.info("name : " + file.getName());
					log.info("size : " + file.getSize());
				
				try {
					/**
					 *  소프트웨어 구축에 쓰이는 식별자 표준
					 *  파일이름이 중복되어 파일이 소실되지 않도록 UUID를 붙여서 저장
					 * */
					UUID uuid =UUID.randomUUID();
					// 파일 이름 (소실방지)  	      식별자 표준 + _ + 파일 원본이름
					String saveFileName =  uuid + "_" + file.getOriginalFilename();

					// dir > c:/upload/2023/7/18  >  년/월/일 
					String uploadPath = getFolder();
					
											// getFolder()는 2023\07\18\ 반환
					File sfile = new File(ATTACHES_DIR + uploadPath + saveFileName);
					
					// 사용자로부터 받아온 file(원본파일) sfile(저장된파일명)에 저장   
					file.transferTo(sfile);
					
					MemberVo membervo = new MemberVo();
					
					// 주어진 파일의 Mime유형을 확인
					String contentType = Files.probeContentType(sfile.toPath());
					
					// Mime 타입을 확인하여 이미지인경우 썸네일을 생성
						if(contentType != null && contentType.startsWith("image")) {
							
							// contetType이 image일 경우, I 
							membervo.setFiletype("I");
							
							String thmbnail = ATTACHES_DIR + uploadPath + "s_" + saveFileName;
							
							// 원본파일(썸네일을 만들 이미지 파일) : sfile / 크키 / thmbnail : 경로 
							Thumbnails.of(sfile).size(100, 100).toFile(thmbnail);
						}else {
							membervo.setFiletype("F");
						}
					
					// file의 정보를 등록 
					membervo.setMno(mno);
					membervo.setFilename(file.getOriginalFilename());
					membervo.setUploadpath(uploadPath);
					membervo.setUuid(uuid.toString());
					
					int res = fileInsert(membervo);
					
					// res의 결과가 0보다 크다면, insertRes의 결과를 증가시킴 
					if(res>0) {
						insertRes++;
					}
					
				} catch (IllegalStateException e1) {
					e1.printStackTrace();
					// ( 에러 발생 시, 호출한 곳에서 오류를 처리하기 때문에 메서드에 throw 던진다~! )
					throw new Exception("첨부파일 등록 중 예외사항이 발생하였습니다.(IllegalStateException오류발생)");
				} catch (IOException e1) {
					e1.printStackTrace();
					throw new Exception("첨부파일 등록 중 예외사항이 발생하였습니다.(IOException)");
				}catch (Exception e) {
					e.printStackTrace();
					throw new Exception("첨부파일 등록 중 예외사항이 발생하였습니다.(Exception)");
				}
			}
			return insertRes;
		}
		/** 파일 삭제 */
		@Override
		public int fileDelete(int mno, String uuid) {
				// 파일 삭제 
			MemberVo membervo = (MemberVo) adminfilemapper.getOne(mno, uuid);
			
				// 삭제할 파일 조회 
			String s_savePath = membervo.getS_savePath();
			String savePath = membervo.getSavePath();
			System.out.println("S_savePath : " + s_savePath);
			System.out.println("savePath : " + savePath);
			
				// 삭제 _ savePath
			if(savePath!= null && !savePath.equals("")) {
				File file = new File(ATTACHES_DIR + savePath);
						// 파일이 존재한다면
				if(file.exists()) {
						// 파일을 삭제하지 못했다면
					if(!file.delete()) {
						System.out.println("path : " + savePath);
						System.out.println("파일 삭제 실 패!");
					};
				}
				
			}
			// 삭제 _ s_savePath
			if(s_savePath!= null && !s_savePath.equals("")) {
				File file = new File(ATTACHES_DIR + s_savePath);
						// 파일이 존재한다면
				if(file.exists()) {
						// 파일을 삭제하지 못했다면
					if(!file.delete()) {
						System.out.println("path : " + s_savePath);
						System.out.println("파일 삭제 실 패!");
					};
				}
				
			}
			return adminfilemapper.fileDelete(mno, uuid);
		}

	
	

}
