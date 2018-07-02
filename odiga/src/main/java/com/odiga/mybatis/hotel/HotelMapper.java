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
		try {
			int num = sqlSession.insert("insertHotel", dto);
			return num;
		} finally {
		}
	}

	public  HotelDTO getHotel(int num) {
		try {
			HotelDTO dto = sqlSession.selectOne("getHotel", num);
			return dto;
		} finally {

		}
	}

	public int updateHotel(HotelDTO dto) {
		try {
			int res = sqlSession.update("updateHotel", dto);
			return res;
		} finally {
		}
	}

	public int deleteHotel(int num) {
		try {
			int res = sqlSession.delete("deleteHotel", num);
			return res;
		} finally {
		}
	}

	public List findHotel_list(String title) {
		try {
			List list = sqlSession.selectList("findHotel_list", title);
			return list;
		} finally {
		}
	}
	
	public void hotel_Score_Popul(double score, int hotel_num, String mode) {
		try {
			HashMap<String, String> hs = new HashMap<>();
			String  sql=null;
			if(mode.equals("up"))
				sql = "update hotel_list set population = population+1, score = '"+score+"' where num = '"+hotel_num+"'";
			else if(mode.equals("down"))
				sql = "update hotel_list set population = population-1, score = '"+score+"' where num = '"+hotel_num+"'";
			hs.put("sql", sql);
			sqlSession.update("hotel_Score_Popul", hs);
		} finally {
			sqlSession.close();
		}
	}
	
	public List cateHotel(String title) {
		try {
			List list = sqlSession.selectList("cateHotel", title);
			return list;
		} finally {
			sqlSession.close();
		}
	}
	
	public List getCheck(List list) {
	      try {
	         List lists = sqlSession.selectList("getCheck", list);
		     return lists;
	         
	      } finally {
	    	  sqlSession.close();
	      }
	   }
 
 public int inputCart(String id, int num) {
	   try {
		   HashMap<String,String> hm=new HashMap<>();
		   String sql="insert into hotel_cart values (hotel_cart_seq.nextval, '"+num+"', '"+id+"')";
		   hm.put("sql", sql);
		   int res=sqlSession.insert("inputCart", hm);
		   sqlSession.commit();
		   return res;
	   }finally {
		   sqlSession.close();
	   }
 }
 
 public  List viewCart(String id, int pageNum) {
	   try {
		   int page = ((pageNum-1) * 6);
		   HashMap<String,String> hm=new HashMap<>();
		   String sql="select * from"
		   		+ "(select rownum rn, A.* from"
		   		+ "(select * from hotel_cart where id='"+id+"' order by num) A)"
		   		+ "where rn between '"+(page+1)+"' and '"+ (page+6) +"'";
		   hm.put("sql", sql);
		   List list=sqlSession.selectList("viewCart", hm);
		   return list;
	   }finally {
		   sqlSession.close();
	   }
 }
 
 public  int countCart(String id) {
	   try {
		   int res=sqlSession.selectOne("countCart", id);
		   return res;
	   }finally {
		   sqlSession.close();
	   }
 }
 
 public int deleteCart(int num, String id) {
	   try {
		   HashMap<String, String> hs = new HashMap<>();
		   String sql = "delete from hotel_cart where num = '" + num + "' and id = '" + id + "'";
		   hs.put("sql", sql);
		   int res=sqlSession.delete("deleteCart",hs);
		   sqlSession.commit();
		   return res;
	   }finally {
		   sqlSession.close();
	   }
 	}
 
 public int getCountSearch(String search) {
		try {
			int count = sqlSession.selectOne("getCountSearch", search);
			return count;
		} finally {
			sqlSession.close();
		}
	}
	
	public List<HotelDTO>getSearch_list(String search, int pageNum){
		try {
			HashMap<String, String> hs = new HashMap<>();
			int page = ((pageNum-1) * 9);
			String sql = "select * from (select rownum rn, A.* from "
					+ "(select * from hotel_list where roadaddrpart1 like '%"+search+"%' or name like '%"+search+"%')A) where rn between '"
					+ (page+1) + "' and '" + (page+9)+"'";
			hs.put("sql", sql);
			List list = sqlSession.selectList("getSearch_list",hs);
			return list;
		} finally {
			sqlSession.close();
		}
	}
	
	public int checkNum(String id, String hotel_num) {
	    try {
	       HashMap<String, String> hm=new HashMap<>();
	       System.out.println("Á¦¹ß : " + id + " : " + hotel_num);
	       String sql = "select count(*) from hotel_cart where id= '"+ id + "'and hotel_num = '"+hotel_num+"'";
	       hm.put("sql", sql);
	       int res=sqlSession.selectOne("checkNum", hm);
	       System.out.println(res);
	       return res;
	    }finally {
	       sqlSession.close();
	    }}
	
}
