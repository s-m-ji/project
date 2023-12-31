package com.project.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.project.controller.FileuploadController;
import com.project.mapper.RecFileMapper2;
import com.project.vo.RecFileVO2;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Service
@Log4j
public class RecFileServiceImpl2  implements RecFileService2{

	@Autowired
	RecFileMapper2 mapper;
	
	@Autowired
	RecStepService2 stepS;
	
	@Override
	public List<RecFileVO2> getList(int bno) {
		// TODO Auto-generated method stub
		return mapper.getList(bno);
	}

	@Override
	public int insert(RecFileVO2 vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////// 요리순서 
	
	@Override
	public int Sfileupload(List<MultipartFile> files, int bno, Model model) throws Exception {
		int insertRes = 0;
		
		int index = 0;
		for(MultipartFile file : files) {
			// 선택된 파일이 없는경우 다음파일로 이동
			if(file.isEmpty()) {
				continue;
			}
			
			log.info("oFileName : " + file.getOriginalFilename());
			log.info("name : " + file.getName());
			log.info("size : " + file.getSize());
			
			try {
				/**
				 * 소프트웨어 구축에 쓰이는 식별자 표준
				 * 파일이름이 중복되어 파일이 소실되지 않도록 uuid를 붙여서 저장
				 */
				UUID uuid = UUID.randomUUID();
				String saveFileName = 
						uuid + "_"+ file.getOriginalFilename();
				
				// dir(c:/upload/2023/07/18)년/월/일
				String uploadpath = getFolder();

				File sFile = 
						new File(FileuploadController.ATTACHES_DIR  //c:\\upload\\
								+ uploadpath   //경로 반환(2023\\07\\18\\)
								+ saveFileName);
				
				// file(원본파일)을 sFile(저장 대상 파일)에 저장
				file.transferTo(sFile);
				

				RecFileVO2 vo = new RecFileVO2();
				// 주어진 파일의 Mime유형을 확인
				String contentType = 
								Files.probeContentType(sFile.toPath());

				// Mime타입을 확인하여 이미지인 경우 썸네일을 생성
				if(contentType != null 
						&& contentType.startsWith("image")) {
					vo.setFiletype("I");
					// 썸네일 생성 경로
					String thmbnail = FileuploadController.ATTACHES_DIR 
										+ uploadpath 
										+ "s_"
										+ saveFileName;
					// 썸네일 생성
					// 원본파일, 크기, 저장될 경로
					Thumbnails
							.of(sFile)
							.size(100, 100)
							.toFile(thmbnail);
				} else {
					vo.setFiletype("F");
				}
				
				vo.setS_NO(stepS.selectStepSEQ());
				vo.setFiletype("S");
				vo.setB_NO(bno);
				vo.setFilename(file.getOriginalFilename());
				//vo.setFiletype("test");
				vo.setUploadpath(uploadpath);
				vo.setUuid(uuid.toString());
				
				int res = stepInsert(vo);
				
				if(res>0) {
					insertRes++;
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(IllegalStateException)");
			} catch (IOException e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(IOException)");
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(Exception)");
			}
		}
		
			
		return insertRes;
	}
	
	
	
	///////////////////////////////////////////////////////////////////////// 완성사진
	@Override
	public int Ffileupload(List<MultipartFile> files, int bno) throws Exception {
		int insertRes = 0;
		for(MultipartFile file : files) {
			// 선택된 파일이 없는경우 다음파일로 이동
			if(file.isEmpty()) {
				continue;
			}
			
			log.info("oFileName : " + file.getOriginalFilename());
			log.info("name : " + file.getName());
			log.info("size : " + file.getSize());
			
			try {
				/**
				 * 소프트웨어 구축에 쓰이는 식별자 표준
				 * 파일이름이 중복되어 파일이 소실되지 않도록 uuid를 붙여서 저장
				 */
				UUID uuid = UUID.randomUUID();
				String saveFileName = 
						uuid + "_"+ file.getOriginalFilename();
				
				// dir(c:/upload/2023/07/18)년/월/일
				String uploadpath = getFolder();

				File sFile = 
						new File(FileuploadController.ATTACHES_DIR  //c:\\upload\\
								+ uploadpath   //경로 반환(2023\\07\\18\\)
								+ saveFileName);
				
				// file(원본파일)을 sFile(저장 대상 파일)에 저장
				file.transferTo(sFile);
				

				RecFileVO2 vo = new RecFileVO2();
				// 주어진 파일의 Mime유형을 확인
				String contentType = 
								Files.probeContentType(sFile.toPath());

				// Mime타입을 확인하여 이미지인 경우 썸네일을 생성
				if(contentType != null 
						&& contentType.startsWith("image")) {
					vo.setFiletype("I");
					// 썸네일 생성 경로
					String thmbnail = FileuploadController.ATTACHES_DIR 
										+ uploadpath 
										+ "s_"
										+ saveFileName;
					// 썸네일 생성
					// 원본파일, 크기, 저장될 경로
					Thumbnails
							.of(sFile)
							.size(100, 100)
							.toFile(thmbnail);
				} else {
					vo.setFiletype("F");
				}
				
				vo.setFiletype("F");
				vo.setB_NO(bno);
				vo.setFilename(file.getOriginalFilename());
				//vo.setFiletype("test");
				vo.setUploadpath(uploadpath);
				vo.setUuid(uuid.toString());
				
				int res = insert(vo);
				
				if(res>0) {
					insertRes++;
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(IllegalStateException)");
			} catch (IOException e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(IOException)");
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("첨부파일 등록중 예외사항이 발생 하였습니다.(Exception)");
			}
		}
		return insertRes;
	}
	
///////////////////////////////////////////////////////////////////////////////////
	
	public int fileupload(List<MultipartFile> files, int bno) throws Exception {
	    int insertRes = 0;
	    boolean isFirstFile = true;  // Flag to check if it's the first file

	    for (MultipartFile file : files) {
	        // If no file is selected, move to the next file
	        if (file.isEmpty()) {
	            continue;
	        }

	        log.info("oFileName : " + file.getOriginalFilename());
	        log.info("name : " + file.getName());
	        log.info("size : " + file.getSize());

	        try {
	            /**
	             * Identifier standards used in building software
	             * Save with uuid so that the file is not lost due to duplicate file names
	             */
	            UUID uuid = UUID.randomUUID();
	            String saveFileName = uuid + "_" + file.getOriginalFilename();

	            // dir(c:/upload/2023/07/18) year/month/day
	            String uploadpath = getFolder();

	            File sFile = new File(FileuploadController.ATTACHES_DIR + uploadpath + saveFileName);

	            // Save file (source file) to sFile (save target file)
	            file.transferTo(sFile);

	            RecFileVO2 vo = new RecFileVO2();
	            vo.setB_NO(bno);
	            vo.setFilename(file.getOriginalFilename());
	            vo.setUploadpath(uploadpath);
	            vo.setUuid(uuid.toString());

	            // Set the filetype based on whether it's the first file or not
	            if (isFirstFile) {
	                vo.setFiletype("B");
	                isFirstFile = false;  // Set the flag to false for the rest of the files
	           
	            } else {
	                vo.setFiletype("S");
	            
	            }

	            int res = insert(vo);

	            if (res > 0) {
	                insertRes++;
	            }
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	            throw new Exception("An exception occurred while registering the attached file. (IllegalStateException)");
	        } catch (IOException e) {
	            e.printStackTrace();
	            throw new Exception("An exception occurred while registering the attached file. (IOException)");
	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new Exception("An exception occurred while registering the attached file. (Exception)");
	        }
	    }
	    return insertRes;
	}
	
	
	public String getFolder() {
		LocalDate currentDate = LocalDate.now();
		String uploadPath 
				= currentDate.toString().replace("-", File.separator)
					+ File.separator;
		log.info("CurrentDate : " + currentDate);
		log.info("경로 : " + uploadPath);
		
		// 폴더 생성(없으면)
		File saveDir = new File(FileuploadController.ATTACHES_DIR + uploadPath);
		if(!saveDir.exists()) {
			if(saveDir.mkdirs()) {
				log.info("폴더 생성!!");
			} else {
				log.info("폴더 생성 실패!!");
			}
		}
		
		
		return uploadPath;
		
	}

	@Override
	public int stepInsert(RecFileVO2 vo) {
		// TODO Auto-generated method stub
		return mapper.stepInsert(vo);
	}


}
