package com.group.mayo.project.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public Project selectProj(int proj_no) {
		return sqlSession.selectOne("Project.selectProj", proj_no);
	}
}
