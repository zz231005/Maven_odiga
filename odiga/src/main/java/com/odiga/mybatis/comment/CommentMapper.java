package com.odiga.mybatis.comment;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.comment.CommentDTO;



@Service
public class CommentMapper {
	
	@Autowired
	private SqlSession sqlSession;

	public  List<CommentDTO> getComment_list(int hotel_num, int pageNum) {
   
	  HashMap<String, String> hs = new HashMap<String, String>();
	   int page = ((pageNum-1)*6);
		String sql = "select * from (select rownum rn, A.* from "
				+ "(select * from comments where hotel_num = "+hotel_num+" order by num desc)A) where rn between '"
				+ (page+1) + "' and '" + (page+6)+"'";
		hs.put("sql", sql);
	   
	   List<CommentDTO> list = sqlSession.selectList("getHotel_Comment",hs);	
	   return list;	
	}


	public  void writeComment(CommentDTO dto) {
      int res = sqlSession.insert("writeComment",dto); 	
     }

	public  int deleteComment(int num, String passwd) {
	
		HashMap<String, String> hs = new HashMap<String, String>();
		String sql = "delete from comments where num='"+num+"' and passwd = '"+ passwd +"'";
		hs.put("sql", sql);
		int res = sqlSession.delete("deleteComment", hs);
		return res;
		
	}


	public  int updateComment(CommentDTO dto) {

		int res = sqlSession.update("updateComment",dto);
		return res;
	}

	
	
	public  int getCountComment(int hotel_num) {
	
		HashMap<String, String> hs = new HashMap<String, String>();
		String sql = "select count(*) from comments where hotel_num = '" + hotel_num + "'";
		hs.put("sql", sql);
		int count = sqlSession.selectOne("getCountComment", hs);
		return count;
		
	}
}
