package com.group.mayo.work.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.project.model.service.ProjectService;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("work")
public class WorkController {
	
	@Autowired
	private ProjectService projService;
	@Autowired
	private WorkService service;
	
	@PostMapping("/detail") // 업무 리스트 불러오기
	public ModelAndView detailWork(ModelAndView mv, @RequestParam("proj_no") String proj_no){
		
		System.out.println("detail 들어온 result" + proj_no);
		
		List<Work> work = service.selectWork(proj_no);
		
		mv.addObject("work", work);
		mv.setViewName("project/workDetail");
		return mv;
	}
	
	@PostMapping("/insert") // 새 업무 글 등록
	public ModelAndView insertWork(ModelAndView mv, Work work, RedirectAttributes rttr
			, @RequestParam(name="uploadfile", required = false) MultipartFile uploadfile
			, HttpServletRequest req) {

//		// 첨부파일있다면 첨부파일 저장
//		if(uploadfile !=null) {
//			String rename_filename = commonFile.saveFile(uploadfile, req);
//			if(rename_filename != null) {
//				//파일저장에 성공하면 DB에 저장할 데이터를 채워줌
//				work.setProj_original_filename(uploadfile.getOriginalFilename());
//				work.setProj_filename(rename_filename);
//			}
//		}
		
		int result = service.insertWork(work);
		
		if(result <= 0) {
			System.out.println("업무 등록 실패 ㅠㅠ");
		} else {
			System.out.println("업무 등록 성공~!~!");
			mv.addObject("proj_no",work.getProj_no());
			mv.setViewName("redirect:/project/select");
		}
		
		return mv;
	}
	

	@PostMapping(value="/update", produces="text/plain;charset=UTF-8") // 업무 글 수정
	@ResponseBody
	public String updateWork(Work work) {
		
		int result= service.updateWork(work);
		
		String msg= "";
		
		if(result<=0) {
			System.out.println("업무 글 수정 실패~!");
			msg="수정에 실패했습니다";
		} else {
			System.out.println("업무 글 수정 성공~!");
			msg="글이 수정되었습니다!";
		}
		return msg;
	}
	
	@PostMapping(value="/delete", produces="text/plain;charset=UTF-8") // 업무 글 삭제
	@ResponseBody
	public String deleteWork(@RequestParam(name="work_no", required=false) String work_no) {
		 
		System.out.println("work delete로 들어왔냐" + work_no);
		int result = service.deleteWork(work_no);
		
		String msg="";
		
		if(result<=0) {
			System.out.println("업무 글 삭제 실패~!");
			msg="삭제에 실패했습니다";
		} else {
			System.out.println("업무 글 삭제 성공~!");
			msg="업무가 삭제되었습니다";
		}
		return msg;
	}

}
