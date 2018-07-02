package com.odiga.mybatis.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.odiga.dto.board.BoardDTO;

@Service
public class BoardMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> BoardList(){
		List<BoardDTO> list = sqlSession.selectList("BoardList");
		return list;
	}
	
	public BoardDTO BoardContent(int no, String mode) {
		BoardDTO res=sqlSession.selectOne("BoardContent", no);
	return res;
	}
	
	public int insertBoard(BoardDTO dto) {
		System.out.println("�̸�:"+dto.getName());
		System.out.println("����:"+dto.getTitle());
		System.out.println("��й�ȣ:"+dto.getPassword());
		System.out.println("����:"+dto.getContent());
		System.out.println("����:"+dto.getTitle());
		System.out.println("��¥:"+dto.getBoard_date());
		int re=sqlSession.insert("insertBoard", dto);
		return re;
	}
	
	
}
