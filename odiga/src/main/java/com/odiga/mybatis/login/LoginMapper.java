package com.odiga.mybatis.login;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginMapper {
	@Autowired
	private SqlSession sqlSession;

	public  String loginCheck(String id, String passwd) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "select name from member where id = '"+ id +"' and passwd = '"+passwd+"'";
		hs.put("sql", sql);
		String name = sqlSession.selectOne("loginCheck",hs);
		if(name == null) {
			return null;
		}
		return name;
	}

	public  String findId(String name, String email) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "select id from member where name = '" + name + "' and email = '" + email + "'";
		hs.put("sql", sql);
		String id = sqlSession.selectOne("findId", hs);
		return id;
	}

	public  int findPwd(String id, String email) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "select count(*) from member where id = '" + id + "' and email = '" + email + "'";
		hs.put("sql", sql);
		int count = sqlSession.selectOne("findPwd", hs);
		return count;
	}

	public  int updatePwd(String id, String passwd) {
		HashMap<String, String> hs = new HashMap<>();
		String sql = "update member set passwd = '" + passwd + "' where id = '" + id + "'";
		hs.put("sql", sql);
		int res = sqlSession.update("updatePwd",hs);
		return res;
	}
}
