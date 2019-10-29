package com.odiga.controller.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.dto.comment.CommentDTO;
import com.odiga.mybatis.comment.CommentMapper;
import com.odiga.mybatis.hotel.HotelMapper;

@Controller
public class CommentAnoController {
	@Autowired
	private CommentMapper commentMapper;
	@Autowired
	private HotelMapper hotelMapper;
	
	
	@RequestMapping(value = "/commentPage.do")
	public ModelAndView CommentPage(int hotel_num, int pageNum) {
		List<CommentDTO> list = commentMapper.getComment_list(hotel_num, pageNum);
		int count = commentMapper.getCountComment(hotel_num);
		int maxPage = count / 6;
		if (count % 6 > 0) {
			maxPage++;
		}
		ModelAndView mav = new ModelAndView("comment/commentPage");
		mav.addObject("commentList", list);
		mav.addObject("num", hotel_num);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxPage", maxPage);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_write.do")
	public void CommentWrite(CommentDTO comment_dto, double score, int population) {
		commentMapper.writeComment(comment_dto);
		double score_total = ((score * population) + comment_dto.getStar_rate()) / (population+1);
		hotelMapper.hotel_Score_Popul(score_total, comment_dto.getHotel_num(), "up");
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_delete.do", method = RequestMethod.POST)
	public int commentDelete(CommentDTO comment_dto, double score, int population) {
		int res = commentMapper.deleteComment(comment_dto.getNum(), comment_dto.getPasswd());
		double score_total = 0;
		System.out.println("나온 값 : " + res);
		if(res > 0) {
			if(population != 1) {
				score_total = (((score * population) - comment_dto.getStar_rate()) / (population-1));
			}
			hotelMapper.hotel_Score_Popul(score_total, comment_dto.getHotel_num(), "down");
		}
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_update.do", method = RequestMethod.POST)
	public int commentUpdatePro(CommentDTO dto) {
		int res = commentMapper.updateComment(dto);
		return res;
	}

	
}