package com.odiga.mybatis.room;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.room.RoomDTO;

@Service
public class RoomMapper {

	@Autowired
	private SqlSession sqlSession; 
	
	public  int insertRoom(RoomDTO dto) {
		int res = sqlSession.insert("insertRoom",dto);
		return 1;
	}
	
	public List getRooms(int hotel_num) {
		List list = sqlSession.selectList("getRooms",hotel_num);
		return list;
	}
 
	
}
