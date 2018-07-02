package com.odiga.mybatis.payment;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.payment.PaymentDTO;


@Service
public class PaymentMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public  int insertPayment(PaymentDTO dto) {
	    int res = sqlSession.insert("insertPayment",dto);
		return 1;
	}
	
	public List<PaymentDTO> getPayment(String id) {
		List<PaymentDTO> list = sqlSession.selectList("getPayment", id);
		return list;
	}
	
	public  List before(String id, int pageNum) {
			int end = pageNum*6;
			int start = end-5;
			
			HashMap<String, String> hm=new HashMap<>();
			hm.put("id", id);
			hm.put("start",String.valueOf(start));
			hm.put("end", String.valueOf(end));
			List bl = sqlSession.selectList("before", hm);
			return bl;
	}
	
	public  List schedule(String id, int pageNum) {
			int end = pageNum*6;
			int start = end-5;
			
			HashMap<String, String> hm=new HashMap<>();
			hm.put("id", id);
			hm.put("start",String.valueOf(start));
			hm.put("end", String.valueOf(end));
			List cl=sqlSession.selectList("schedule", hm);
			return cl;
	}
	
	public int before_count(String id) {
			int count = sqlSession.selectOne("before_count", id);
			return count;
	}
	
	public int schedule_count(String id) {
			int count = sqlSession.selectOne("schedule_count", id);
			return count;
	}
	
	public  int deletePay(int num, String id) {
			HashMap<String,  String> hs = new HashMap<>();
			System.out.println("mapper" + num + " : " + id);
			String sql = "delete from payment where num = " + num + " and  id = '" + id + "'";
			hs.put("sql", sql);
			int res = sqlSession.delete("deletePay", hs);
			return res;
	}

	public  List<PaymentDTO> nonmem_getPay(String name, String email, String pay_mode, int pageNum) {
		int end = pageNum *6;
		int start = end-5;
			
			pay_mode = pay_mode + "//@//" + name;
			String sql = "select * from (select rownum rn, A.* from "
					+ "(select * from payment  where  id = '" + email +"' and pay_mode like '%" + pay_mode + "%')A) where rn between '"
					+ start + "' and '" + end+"'";
			
			//String sql = "select * from payment  where  id = '" + email +"' and pay_mode like '%" + pay_mode + "%'";
			HashMap<String, String> hm = new HashMap<>();
			hm.put("sql", sql);
			List list = sqlSession.selectList("nonmem_getPay", hm);
			return list;
	}
	
	public  int nonmem_count(String name, String email, String pay_mode) {
		
			pay_mode = pay_mode + "//@//" + name;
			String sql = "select count(*) from payment  where  id = '" + email +"' and pay_mode like '%" + pay_mode + "%'";
			HashMap<String, String> hm = new HashMap<>();
			hm.put("sql", sql);
			int count = sqlSession.selectOne("nonmem_count", hm);
			return count;
	}
	
	public int deletePayment(String id) {
			int res = sqlSession.delete("deletePayment", id);
			return res;
	}
}
