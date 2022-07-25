package com.group.mayo.work.model.service;

import java.util.List;

import com.group.mayo.work.domain.Comment;

public interface CommentService {

	public List<Comment> selectComment(String work_no);
	
	public int insertComment(Comment comment);
	
	public int deleteComment(String comment_no);
}
