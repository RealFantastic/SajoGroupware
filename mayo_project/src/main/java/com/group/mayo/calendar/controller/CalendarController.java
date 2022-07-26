package com.group.mayo.calendar.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.service.EmpService;
import com.group.mayo.project.domain.Project;
import com.group.mayo.project.model.service.ProjectService;
import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("calendar")
public class CalendarController {

	@Autowired
	private ProjectService projservice;
	@Autowired
	private WorkService workservice;
	@Autowired
	private ScheduleService service;
	
	@Autowired
	private EmpService empservice;
	
	// 캘린더로 넘어가기~!
	@GetMapping("/view")
	public ModelAndView viewCal(ModelAndView mv, HttpSession session) { 

		Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
		String emp_no = loginEmp.getEmp_no();
		
		List<Work> work = workservice.selectAllWork(emp_no);
		List<Project> proj = projservice.selectAllProj(emp_no);
		List<Schedule> sked = service.selectAllSked(emp_no);
		List<Schedule> skedA = service.selectSkedA();
		List<Schedule> skedP = service.selectSkedP(emp_no);

		List<Employee> emplist = empservice.selectListEmp();
		
		Employee emp = (Employee)session.getAttribute("loginSsInfo");
		
		mv.addObject("schedule", sked); // 프로젝트
		mv.addObject("scheduleA", skedA); //전사
		mv.addObject("scheduleP", skedP); // 개인
		mv.addObject("employee", emp);
		mv.addObject("project", proj);
		mv.addObject("emplist", emplist);
		mv.addObject("work", work); // 업무 글 데이터 들고가기
		mv.setViewName("calendar/view");
		return mv;
	}
}
