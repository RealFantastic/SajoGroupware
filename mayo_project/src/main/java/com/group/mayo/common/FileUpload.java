package com.group.mayo.common;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUpload {

	public String saveFile(MultipartFile report, HttpServletRequest request) {
		String result_filename = null;
		long timeForRename = System.currentTimeMillis();
		String realPath = request.getSession().getServletContext().getRealPath("");
		String savePath = "resources\\uploadFiles";
		File folder = new File(realPath+savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		String filePath = realPath+savePath+"\\"+ timeForRename +"_"+report.getOriginalFilename();
		try {
			report.transferTo(new File(filePath));// 파일 저장
			
			// 파일저장 성공
			result_filename = "resources/uploadFiles/"+ timeForRename +"_"+report.getOriginalFilename();
		} catch (IllegalStateException e) {
			// 파일저장 실패
			e.printStackTrace();
		} catch (IOException e) {
			// 파일저장 실패
			e.printStackTrace();
		}   
		// 파일저장 실패시 null, 성공시 저장한파일경로와파일명
		return result_filename;
	}
	

	public void removeFile(String board_file, HttpServletRequest request) {
		String resourcesPath = "resources";
		String uploadPath = "uploadFiles";
		
		String root = request.getSession().getServletContext().getRealPath(resourcesPath);
		String savePath = root + "\\"+ uploadPath;

		System.out.println("remove file b:"+board_file);
		board_file = board_file.substring(board_file.lastIndexOf("/")+1);
		System.out.println("remove file a:"+board_file);
		
		String filePath = savePath + "\\" + board_file;
		try {
			// 파일 저장
			System.out.println(board_file + "을 삭제합니다.");
			System.out.println("기존 저장 경로 : " + savePath);

			File delFile = new File(filePath);
			delFile.delete();

			System.out.println("파일 삭제가 완료되었습니다.");
		} catch (Exception e) {
			System.out.println("파일 삭제 에러 : " + e.getMessage());
		}
	}
	
}
