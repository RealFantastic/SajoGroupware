package com.group.mayo.work.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.project.domain.Project;
import com.group.mayo.work.domain.Comment;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.CommentService;

@Controller
@RequestMapping("comment")
public class CommentController {

	@Autowired
	private CommentService service;
	// 댓글
	@GetMapping("/list") 
	public ModelAndView selectComment(ModelAndView mv,@RequestParam(name="work_no", required=false) String work_no){
		
		List<Comment> comment = service.selectComment(work_no);		
		
		mv.addObject("comment", comment);
		mv.setViewName("project/insideproj");
		return mv;
	}
	
	// 댓글 등록
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8") 
	public String insertComment(ModelAndView mv, Comment comment, HttpSession session, RedirectAttributes rttr) {
		
		Employee employee = (Employee)session.getAttribute("loginSsInfo");
		comment.setC_writer(employee.getEmp_no());
		
		int result = service.insertComment(comment);
	
		System.out.println(comment);
		
		String msg="";
		
		if(result <= 0) {
			System.out.println("댓글 등록 실패");
			msg="등록에 실패했습니다";
		} else {
			msg="댓글이 등록됐습니다";
		}
		return msg;	
	}
	
	// 댓글 삭제
	@PostMapping(value="/delete", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String deleteProj(@RequestParam(name="proj_no", required=false) String proj_no) {
		int result = service.deleteComment(proj_no);
		String msg="";
		
		if(result <= 0) {
			System.out.println("삭제실패");
			msg="삭제에 실패했습니다";
		} else {
			msg="프로젝트가 삭제되었습니다";
		}
		return msg;			
		
	}
}
