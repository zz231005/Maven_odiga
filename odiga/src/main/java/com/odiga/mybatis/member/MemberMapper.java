package com.odiga.mybatis.member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.member.MemberDTO;

@Service
public class MemberMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public  int insertMember(MemberDTO dto) {
		int res=sqlSession.insert("insertMember",dto);
		return res;
	}

	public  List listMember() {
		List list = sqlSession.selectList("listMember");
		return list;
	}

	public  int idCheck(String id) {
		int idCheck = sqlSession.selectOne("idCheck", id);
		return idCheck;
	}
	
	public  int emailCheck(String email) {
		int count = sqlSession.selectOne("emailCheck", email);
		return count;
	}
	
	public  MemberDTO getMember(String id) {
		MemberDTO dto =sqlSession.selectOne("getMember", id);
		return dto;
	}
	
	public  int updateMember(HashMap<String,String> hm) {
		int res=sqlSession.update("updateMember", hm);
		return res;
	}

	public  int pointEdit(int points, String id) {
		HashMap<String, String> hm=new HashMap<>();
		String sql = "update member set points = points + '"+points+"' where id = '"+ id + "'";
		hm.put("sql", sql);
		int res=sqlSession.update("pointEdit", hm);
		return res;
	}
	
	public  int getPoint(String id) {
		int point = sqlSession.selectOne("getPoint", id);
		return point;
	}
	
	public  String isPasswd(String id, String passwd) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "select id from member where id = '"+ id +"' and passwd = '"+passwd+"'";
		hs.put("sql", sql);
		String check = sqlSession.selectOne("isPasswd",hs);
		if(check == null) {
			return null;
		}
		return check;
	}
	
	public  int deleteMember(String id) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "delete from member where id='"+id+"'";
		hs.put("sql", sql);
		int res = sqlSession.delete("deleteMember", hs);
		return res;
	}
	
}
