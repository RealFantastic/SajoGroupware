package com.group.mayo.employee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.department.service.DeptService;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.service.EmpService;
import com.group.mayo.holidayEmp.service.EmpHolidayService;


@Controller
@RequestMapping("member")
public class EmpController {
	@Autowired
	private EmpService service;
	
	@Autowired
	private DeptService dservice;
	
	@Autowired
	private EmpHolidayService hservice;
	
	@Autowired
	private SignFileUpload commonFile;


	@Inject
	private JavaMailSender mailSender;
	
	@Inject
	private BCryptPasswordEncoder pwdEncoding;
	
	@GetMapping("/list")
	public ModelAndView selectEmp(ModelAndView mv) {
		
		List<Employee> emp = service.selectListEmp();
		
		System.out.println(emp);
		mv.addObject("emp", emp);
		mv.setViewName("member/list");
		
		return mv;
	}
	
	@PostMapping(value="/empchart", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectEmpChart(ModelAndView mv) {
		//사원 목록
//		List<Employee> emplist = service.selectListEmp();
		//부서목록
		List<Map<String,Object>> deptlist = dservice.selectDeptList();
		System.out.println(deptlist);
		//루트, 트리 노드 저장용
		List<Object> treeList = new ArrayList<Object>();
	
		//루트 노드용 맵
		Map<String,Object> root = new HashMap<String, Object>();
//		Map<String,Object> root2 = new HashMap<String, Object>();
		Map<String,Object> rootState = new HashMap<String, Object>();
		

		root.put("id", "0");
		root.put("children",deptlist);
		root.put("text", "마요그룹");
		rootState.put("opened", true);
		root.put("state", rootState);
		treeList.add(root);
		
//		[
	//		{children=[
	//			{id=202210001, text=박정환}, 
	//			{id=202230001, text=호호호}, 
	//			{id=202210004, text=참주먹}],
	//		 id=10, text=인사팀}, 
	//		{children=[
	//			{id=202220123, text=김혜린}], 
	//		id=20, text=영업팀}, 
	//		{children=[], id=30, text=총무팀}
//		]
		
		
		//부서목록 list -> map으로 변환
//		for(Dept dept : deptlist) {
//			Map<String,Object> tree = new HashMap<String, Object>();
//			Map<String,Object> treeState = new HashMap<String, Object>();
//			
//			System.out.println("반복" + dept);
//			tree.put("id", dept.getDept_no());
//			tree.put("parent",root.get("parent"));
//			tree.put("text",dept.getDept_name());
//			treeState.put("opened", true);
//			tree.put("state", treeState);	
//			treeList.add(tree);	
//			for(int i=0; i<dept.getEmplist().size(); i++) {
//				Map<String,Object> tree2 = new HashMap<String, Object>();
//				Map<String,Object> treeState2 = new HashMap<String, Object>();
//				tree2.put("id", dept.getEmplist().get(i).getEmp_no());
//				tree2.put("parent", dept.getEmplist().get(i).getDept_no());
//				tree2.put("text", dept.getEmplist().get(i).getEmp_name());
//				treeState2.put("opened", true);
//				tree2.put("state", treeState);
//				treeList.add(tree2);
//			}
//		}
		
		
		//사원목록 list -> map으로 변환
//		for(Employee employee : emplist) {
//			Map<String,Object> tree = new HashMap<String, Object>();
//			Map<String,Object> treeState = new HashMap<String, Object>();
//
//			System.out.println("반복" + employee);
//			
//			tree.put("id", employee.getEmp_no());
//			tree.put("parent", employee.getDept_no());
//			tree.put("text",employee.getEmp_name());
//			treeState.put("opened", true);
//			tree.put("state", treeState);
//			treeList.add(tree);
//		}
//		
		
		//Json 형변환
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		String jsonRoot = gson.toJson(treeList);
		
		
		return jsonRoot;
	}
	
	@PostMapping(value="/detail" ,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectMember(@RequestParam(name="emp_no", required=false) String emp_no) {
		System.out.println("들어왔다");
		Employee employee = service.selectEmployee(emp_no);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		String empJson = gson.toJson(employee);
		
		return empJson;
	}
	
	@RequestMapping(value = "enroll", method = RequestMethod.GET)
	public ModelAndView pageInsert(ModelAndView mv) {
		mv.setViewName("member/insert");
		return mv;
	}
	@PostMapping("/enroll")
	public ModelAndView insert(ModelAndView mv
			, RedirectAttributes rttr
			, Employee employee
			, HolidayEmployee hemployee
			, @RequestParam(name="sign_file", required = false) MultipartFile sign_file
			, @RequestParam(name="pic_file", required = false) MultipartFile pic_file
			, HttpServletRequest req
			) {
		
		//암ㅎ화
		employee.setPassword(pwdEncoding.encode(employee.getPassword()));
		// 첨부파일있다면 첨부파일 저장
		if(sign_file !=null) {
			String rename_filename = commonFile.saveFile(sign_file, req);
			if(rename_filename != null) {
				//파일저장에 성공하면 DB에 저장할 데이터를 채워줌
				employee.setSign_path(sign_file.getOriginalFilename());
				employee.setSign_file_name(rename_filename);
			}
		}
		if(pic_file !=null) {
			String rename_picname = commonFile.saveFile(pic_file, req);
			if(rename_picname != null) {
				//파일저장에 성공하면 DB에 저장할 데이터를 채워줌
				employee.setPic_path(pic_file.getOriginalFilename());
				employee.setPic_name(rename_picname);
			}
		}
		int result = service.insertEmployee(employee);
		
		
		if(result < 1) {
			rttr.addFlashAttribute("msg", "가입에 실패했습니다. 다시 회원가입 시도해주세요.");
			mv.setViewName("redirect:/member/enroll");
			return mv;
		}
		int insert = hservice.insertTotal(hemployee);
		if(insert != 0) {
			rttr.addFlashAttribute("msg", "가입이 완료되었습니다.");
			mv.setViewName("redirect:/");	
		}
		return mv;
	}		
	// 로그인
	@GetMapping("/login")
	public ModelAndView pageLogin(ModelAndView mv) {
		mv.setViewName("member/login");
		return mv;
	}
	@PostMapping("/login")
	public ModelAndView selectLogin(ModelAndView mv
			, Employee employee
			, RedirectAttributes rttr
			, HttpSession session
			) {
		
		if(session.getAttribute("loginSsInfo") != null ) {
			session.removeAttribute("loginSsInfo");
		}
		Employee result = service.selectLogin(employee);
		
		if(result != null) {
			
			if(pwdEncoding.matches(employee.getPassword(), result.getPassword()) || employee.getPassword().equals(result.getPassword()) ) {
				session.setAttribute("loginSsInfo", result);
				rttr.addFlashAttribute("msg", "안녕하세요 "+result.getEmp_name()+" "+result.getJob_name()+"님!");
				mv.setViewName("redirect:/");
			}
		}
		else {
		rttr.addFlashAttribute("msg", "로그인에 실패했습니다. 아이디와 패스워드를 다시 확인해주세요.");
		mv.setViewName("redirect:/member/login");
		}
		//TODO 메인페이지 연결
		return mv;
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public ModelAndView logout(ModelAndView mv
			,RedirectAttributes rttr
			,HttpSession session){
		session.removeAttribute("loginSsInfo");
		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		mv.setViewName("redirect:/member/login");
		return mv;
	}
	//아이디 중복 체크
	 @PostMapping(value="/checkno",produces="text/plain;charset=UTF-8")
	 @ResponseBody
	 public String checkCpNumber(
			 @RequestParam("emp_no") String emp_no
			 ,RedirectAttributes rttr) {
		 String ro = null;
		 int result=service.checkEmpNo(emp_no);  
		 	if(result != 0 || emp_no.equals("") || emp_no.length() != 9) {
		 		ro= "false";
		 	}else {
		 		ro ="ok";
		 	}
		 	
		 	return ro;
	 }
	//주민번호 중복 체크
	 @PostMapping(value="/checkrrn",produces="text/plain;charset=UTF-8")
	 @ResponseBody
	 public String checkRrn(
			 @RequestParam("rrn") String rrn
			 ) {
		 int result=service.checkRrn(rrn);  
		 String ro = null;
			 	if(result == 1 || rrn.equals("") || rrn.length() != 14) {
			 		ro= "false";
			 	}else {
			 		ro ="ok";
			 	}
			 	
			 	return ro;
	 }
	//사업자번호 조회
	 @PostMapping(value="/checkcpnum",produces="text/plain;charset=UTF-8")
	 @ResponseBody
	 public String chkcpNum(
			 @RequestParam("cp_number") String cp_number
			 ) {
		 	
		 	int result=service.checkCpNumber(cp_number);  
		 	String ro = null;
		 	if(result == 1 || cp_number.equals("") || cp_number.length() != 12) {
		 		ro= "false";
		 	}else {
		 		ro ="ok";
		 	}
		 	System.out.println(ro);
		 	return ro;
	 }
	 
	 @RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	 @ResponseBody
	 public String mailCheck(@RequestParam("email") String totalemail) throws Exception{
	     int serti = (int)((Math.random()* (99999 - 10000 + 1)) + 10000);
	     
	     String from = "xeonsnee@naver.com";//보내는 이 메일주소
	     String to = totalemail;
	     String title = "[MAYO 그룹웨어] 회원가입시 필요한 인증번호 입니다.";
	     String content = "[인증번호] "+ serti +" 입니다. <br/> 인증번호 확인란에 기입해주십시오.";
	     String num = "";
	     try {
	     	 MimeMessage mail = mailSender.createMimeMessage();
	         MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	         
	         mailHelper.setFrom(from);
	         mailHelper.setTo(to);
	         mailHelper.setSubject(title);
	         mailHelper.setText(content, true);       
	         if(totalemail != null) {
	        	 
	        	 mailSender.send(mail);
	        	 num = Integer.toString(serti);
	         }
	         
	     } catch(Exception e) {
	         num = "error";
	     }
	     return num;
	 }
		@RequestMapping(value = "invite", method = RequestMethod.GET)
		public ModelAndView pageinvite(ModelAndView mv) {
			mv.setViewName("member/invite");
			return mv;
		}
		@PostMapping("/invite")
		public ModelAndView inviteMail(ModelAndView mv
				, Employee employee
				, RedirectAttributes rttr
				, HttpSession session
				) {
			
			return mv;
		}
	 @RequestMapping(value = "/inviteMail", method = RequestMethod.GET)
	 @ResponseBody
	 public boolean  inviteMail(
			 @RequestParam("email") String email
			 ) throws Exception{
	     
	     String from = "xeonsnee@naver.com";//보내는 이 메일주소
	     String to = email;
	     String title = "[MAYO 그룹웨어] 마요그룹웨어에 초대 받았습니다! ";
	     //String content = "아래 링크를 클릭하여 회원가입을 진행해주세요./n ";
	    // String url = "";
	     try {
	     	 MimeMessage mail = mailSender.createMimeMessage();
	         MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	         
	         mailHelper.setFrom(from);
	         mailHelper.setTo(to);
	         mailHelper.setSubject(title);
	         mailHelper.setText("text/html","<html><p>아래 링크를 클릭하여 회원가입을 완료해주십시오.</p><div><a href='localhost:8090/mayo/member/enroll'>회원가입 하러가기</a></div></html>");       
	         
	         mailSender.send(mail);
	         //url = "member/invite";
	         
	     } catch(Exception e) {
	    	 return false;
	     }
	     return true;
	 }
	 
	    // 아이디 찾기 페이지 이동
		//@RequestMapping(value="/findId",  method=RequestMethod.GET)
	 	@GetMapping("/findId")
		public ModelAndView findIdView(ModelAndView mv) {
			mv.setViewName("member/find_id");
			return mv;
		}
	    // 아이디 찾기 실행
		@RequestMapping(value="findId", method=RequestMethod.POST, produces="text/plain;charset=UTF-8" )
		@ResponseBody
		public String findId(Employee employee
				, RedirectAttributes rttr
				,@RequestParam("emp_name") String emp_name
				,@RequestParam("rrn") String rrn
				) {
			Employee findId = service.findId(employee);
			String result = "fail";
			  try {
	
				  if(findId == null || emp_name.equals("") || rrn.equals("")) { 
					  return result;
				  } else {
					  result = findId.getEmp_no();
				  }
				  
			  }catch (Exception e) {
				  result = "error";
			}
			return result;
		}
		
	    // 비밀번호 찾기 페이지로 이동
		@GetMapping("/findPwd")
		public ModelAndView findPwdView(ModelAndView mv) {
			mv.setViewName("member/find_pwd");
			return mv;
		}
		
	    // 비밀번호 찾기 실행
		@RequestMapping(value="findPwd", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String findPwd(Employee employee
							, ModelAndView mv) {
			
			Employee findPwd = service.findPwd(employee);
			
			String result = null;
			if(findPwd == null) { 
				System.out.println("findPwd : "+findPwd);
				result ="fail";
			} else {
				result = "ok";
			}
			System.out.println("result"+result);
			return result;
		}
	 	@GetMapping("/chkFindPwd")
		public ModelAndView chkFindPwd(ModelAndView mv) {
			mv.setViewName("member/chk_findPwd");
			return mv;
		}
		 @RequestMapping(value = "/findPwdEmail", method = RequestMethod.GET)
		 @ResponseBody
		 public String findPwdEmail(@RequestParam("email") String totalemail
				 	) throws Exception{
		     int serti = (int)((Math.random()* (99999 - 10000 + 1)) + 10000);
		     
		     String from = "xeonsnee@naver.com";//보내는 이 메일주소
		     String to = totalemail;
		     String title = "[MAYO 그룹웨어] 본인인증시 필요한 인증번호 입니다.";
		     String content = "[인증번호] "+ serti +" 입니다. <br/> 인증번호 확인란에 기입해주십시오.";
		     String num = "";
		     try {
		     	 MimeMessage mail = mailSender.createMimeMessage();
		         MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		         
		         mailHelper.setFrom(from);
		         mailHelper.setTo(to);
		         mailHelper.setSubject(title);
		         mailHelper.setText(content, true);       
		         
		         mailSender.send(mail);
		         num = Integer.toString(serti);
		         
		       
		     } catch(Exception e) {
		         num = "error";
		     }
		     return num;
		 }
		//비밀번호 재설정 페이지 
	 	@GetMapping("/updatePwd")
		public ModelAndView updatePwdView(ModelAndView mv) {
			mv.setViewName("member/updatePwd");
			return mv;
	 	}
	    // 비밀번호 재설정 실행
		@RequestMapping(value="updatePwd", method=RequestMethod.POST)
		@ResponseBody
		public ModelAndView updatePwd(
			Employee employee
			,ModelAndView mv 
			,RedirectAttributes rttr
			,HttpSession session) {
			
			employee.setPassword(pwdEncoding.encode(employee.getPassword()));
			Employee updatdPwd = service.updatePwd(employee);
		
			if(updatdPwd == null) {
				rttr.addFlashAttribute("msg", "비밀번호 변경을 실패하였습니다. 다시시도 해주세요.");
				mv.setViewName("redirect:/member/updatePwd");
			}else {
				
				session.invalidate();
				rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.다시 로그인 해주세요.");
				mv.setViewName("redirect:/member/login");
			}

		return mv;
		
								

	}

}
