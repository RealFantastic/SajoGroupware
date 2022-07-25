package com.group.mayo.project.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.project.domain.Project;

@Repository
public class ProjectDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Project> selectAllProj(){
		return sqlSession.selectList("Project.selectAllProj");
	}
	
	public int insertProj(Project proj) {
		return sqlSession.insert("Project.insertProj", proj);
	}
	
	public int updateProj(Project proj) {
		return sqlSession.update("Project.updateProj", proj);
	}
	
	public int deleteProj(String proj_no) {
		return sqlSession.delete("Project.deleteProj", proj_no);
	}
	
	public Project selectProj(String proj_no) {
		return sqlSession.selectOne("Project.selectProj", proj_no);
	}
	
	public int insertPic(Employee emp) {
		return sqlSession.insert("Project.insertPic", emp);
	}
	
	public int deletePic(String emp_no) {
		return sqlSession.delete("Project.deletePic", emp_no);
	}
}
