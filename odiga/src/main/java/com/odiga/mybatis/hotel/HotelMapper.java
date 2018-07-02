package com.odiga.mybatis.hotel;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.hotel.HotelDTO;

@Service
public class HotelMapper {

	@Autowired
	private SqlSession sqlSession;

	public List<HotelDTO> listHotel() {
	
		try {
			List list = sqlSession.selectList("listHotel");
			return list;
		} finally {
		}
	}

	public int insertHotel(HotelDTO dto) {
		int num = sqlSession.insert("insertHotel", dto);
		return num;
	}

	public  HotelDTO getHotel(int num) {
		HotelDTO dto = sqlSession.selectOne("getHotel", num);
		return dto;
	}

	public int updateHotel(HotelDTO dto) {
		int res = sqlSession.update("updateHotel", dto);
		return res;
	}

	public int deleteHotel(int num) {
		int res = sqlSession.delete("deleteHotel", num);
		return res;
	}

	public List findHotel_list(String title) {
		List list = sqlSession.selectList("findHotel_list", title);
		return list;
	}
	
	public void hotel_Score_Popul(double score, int hotel_num, String mode) {
		HashMap<String, String> hs = new HashMap<>();
		String  sql=null;
		if(mode.equals("up"))
			sql = "update hotel_list set population = population+1, score = '"+score+"' where num = '"+hotel_num+"'";
		else if(mode.equals("down"))
			sql = "update hotel_list set population = population-1, score = '"+score+"' where num = '"+hotel_num+"'";
		hs.put("sql", sql);
		sqlSession.update("hotel_Score_Popul", hs);
	}
	
	public List cateHotel(String title) {
		List list = sqlSession.selectList("cateHotel", title);
		return list;
	}
	
	public List getCheck(List list) {
         List lists = sqlSession.selectList("getCheck", list);
	     return lists;
	   }
 
 public int inputCart(String id, int num) {
	   HashMap<String,String> hm=new HashMap<>();
	   String sql="insert into hotel_cart values (hotel_cart_seq.nextval, '"+num+"', '"+id+"')";
	   hm.put("sql", sql);
	   int res=sqlSession.insert("inputCart", hm);
	   return res;
 }
 
 public  List viewCart(String id, int pageNum) {
	   int page = ((pageNum-1) * 6);
	   HashMap<String,String> hm=new HashMap<>();
	   String sql="select * from"
	   		+ "(select rownum rn, A.* from"
	   		+ "(select * from hotel_cart where id='"+id+"' order by num) A)"
	   		+ "where rn between '"+(page+1)+"' and '"+ (page+6) +"'";
	   hm.put("sql", sql);
	   List list=sqlSession.selectList("viewCart", hm);
	   return list;
 }
 
 public  int countCart(String id) {
	   int res=sqlSession.selectOne("countCart", id);
	   return res;
 }
 
 public int deleteCart(int num, String id) {
	   HashMap<String, String> hs = new HashMap<>();
	   String sql = "delete from hotel_cart where num = '" + num + "' and id = '" + id + "'";
	   hs.put("sql", sql);
	   int res=sqlSession.delete("deleteCart",hs);
	   return res;
 	}
 
 public int getCountSearch(String search) {
		int count = sqlSession.selectOne("getCountSearch", search);
		return count;
	}
	
	public List<HotelDTO>getSearch_list(String search, int pageNum){
		HashMap<String, String> hs = new HashMap<>();
		int page = ((pageNum-1) * 9);
		String sql = "select * from (select rownum rn, A.* from "
				+ "(select * from hotel_list where roadaddrpart1 like '%"+search+"%' or name like '%"+search+"%')A) where rn between '"
				+ (page+1) + "' and '" + (page+9)+"'";
		hs.put("sql", sql);
		List list = sqlSession.selectList("getSearch_list",hs);
		return list;
	}
	
	public int checkNum(String id, String hotel_num) {
       HashMap<String, String> hm=new HashMap<>();
       String sql = "select count(*) from hotel_cart where id= '"+ id + "'and hotel_num = '"+hotel_num+"'";
       hm.put("sql", sql);
       int res=sqlSession.selectOne("checkNum", hm);
       return res;
       }
	
}
