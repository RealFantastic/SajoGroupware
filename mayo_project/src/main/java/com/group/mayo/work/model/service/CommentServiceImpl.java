package com.group.mayo.work.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.work.domain.Comment;
import com.group.mayo.work.model.dao.CommentDao;

@Service
@Transactional
public class CommentServiceImpl implements CommentService{

	@Autowired
	private CommentDao dao;
	
	@Override
	public List<Comment> selectComment(String work_no) {
		return dao.selectComment(work_no);
	}

	@Override
	public int insertComment(Comment comment) {
		return dao.insertComment(comment);
	}

	@Override
	public int deleteComment(String comment_no) {
		return dao.deleteComment(comment_no);
	}

}
