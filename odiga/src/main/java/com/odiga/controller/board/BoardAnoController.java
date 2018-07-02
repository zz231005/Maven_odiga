package com.odiga.controller.board;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.dto.board.BoardDTO;
import com.odiga.mybatis.board.BoardMapper;

@Controller
public class BoardAnoController {
	
	@Autowired
	private BoardMapper boardMapper;
	
	//�Խñ� ����Ʈ
	@RequestMapping(value="board.do")
	public ModelAndView BoardList() {
		ModelAndView mav = new ModelAndView("board/list");
		List<BoardDTO> boardList=boardMapper.BoardList();
		mav.addObject("boardList", boardList);
		return mav;
	}
	
	//�۾��� ��
	@RequestMapping(value="insertBoard.do")
	public ModelAndView BoardInsert() {
		return new ModelAndView("board/insertBoard");
	}
	
	//�۾���
	@RequestMapping(value="board_inset.do")
	public ModelAndView insertBoard(BoardDTO dto) {
		boardMapper.insertBoard(dto);
		return new ModelAndView("redircet:board.do");
	}
	//�� �󼼺���
	@RequestMapping(value="content.do")
	public String Content(HttpServletRequest req, @RequestParam int no) {
		BoardDTO dto= boardMapper.BoardContent(no, "content");
		req.setAttribute("dto", dto);
		return "board/content";
	} 
}
