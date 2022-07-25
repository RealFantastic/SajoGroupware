package com.group.mayo.work.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.work.domain.Comment;
import com.group.mayo.work.domain.Work;

@Repository
public class CommentDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<Comment> selectComment(String work_no) {
		return sqlSession.selectList("Comment.selectComment");
	}
	
	public int insertComment(Comment comment) {
		return sqlSession.insert("Comment.insertComment", comment);
	}
	
	public int deleteComment(String comment_no) {
		return sqlSession.delete("Comment.deleteComment", comment_no);
	}
}
