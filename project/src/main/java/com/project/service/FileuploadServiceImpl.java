package com.project.service;

import java.io.File;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.controller.FileuploadController;
import com.project.mapper.FileuploadMapper;
import com.project.vo.FileuploadVo;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Service
@Log4j
public class FileuploadServiceImpl implements FileuploadService{

	@Autowired
	FileuploadMapper mapper;
	
	@Override
	public List<FileuploadVo> getFileList(int bno) {
		// TODO Auto-generated method stub
		return mapper.getFileList(bno);
	}

	@Override
	public List<FileuploadVo> getRecipeStep(int bno) {
		// TODO Auto-generated method stub
		return mapper.getRecipeStep(bno);
	}

	@Override
	public List<FileuploadVo> getPhotoReview(int bno) {
		// TODO Auto-generated method stub
		return mapper.getPhotoReview(bno);
	}

	@Override
	public FileuploadVo getIngredients(int i_no) {
		// TODO Auto-generated method stub
		return mapper.getIngredients(i_no);
	}

	/**
	 * 첨부파일 저장 및 데이터 베이스 등록
	 */
	@Override
	public int fileupload(List<MultipartFile> files, int bno, int r_no) {
		
		int insertRes = 0;
		// 반복
		for(MultipartFile file : files) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			
			log.info("oFileName : " + file.getOriginalFilename());
			log.info("name : " + file.getName());
			log.info("size : " + file.getSize());
			
			try {
				
				UUID uuid = UUID.randomUUID();
				String saveFileName = 
						uuid + "_" + file.getOriginalFilename();
				
				String uploadpath = getFolder();
				
				File sFile = 
						new File(FileuploadController.ATTACHES_DIR
								+ uploadpath
								+ saveFileName);
				
				file.transferTo(sFile);
				
				FileuploadVo vo = new FileuploadVo();
				
				String contentType = 
							Files.probeContentType(sFile.toPath());
			
				
				String thmbnail = FileuploadController.ATTACHES_DIR
										+ uploadpath
										+ "s_"
										+ saveFileName;
					
				Thumbnails
							.of(sFile)
							.size(100, 100)
							.toFile(thmbnail);	
				
				vo.setR_no(r_no);
				vo.setB_no(bno);
				vo.setFilename(file.getOriginalFilename());
				vo.setUploadpath(uploadpath);
				vo.setUuid(uuid.toString());
				vo.setFiletype("R");
				
				int res = insertFile(vo);
				
				if(res > 0) {
					insertRes++;
				}
				
			}catch (Exception e) {
				// TODO: handle exception
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
	public int insertFile(FileuploadVo vo) {
		// TODO Auto-generated method stub
		return mapper.insertFile(vo);
	}

	@Override
	public List<FileuploadVo> getFinishImg(int bno) {
		// TODO Auto-generated method stub
		return mapper.getFinishImg(bno);
	}

	@Override
	public FileuploadVo getMemberImg(int m_no) {
		// TODO Auto-generated method stub
		return mapper.getMemberImg(m_no);
	}

}
