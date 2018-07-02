package com.odiga.controller.index;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.odiga.dto.member.MemberDTO;
import com.odiga.mybatis.member.MemberMapper;

@Controller
public class IndexController {
	private static String [] CITY_LIST = {"서울","인천","춘천", "청주", "대전", "안동", "전주", "포항", "대구", "울산", "부산", "창원", "여수", "광주", "제주"};
	@Autowired
	private MemberMapper memberMapper;
	
	@RequestMapping(value="/index.do")
	public ModelAndView index(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		ModelAndView mav=new ModelAndView("odiga/top_head");
		HttpSession session=req.getSession();
		HashMap<String, String> hm=(HashMap<String, String>) session.getAttribute("user");
		if(hm != null) {
			String id=hm.get("id");
			MemberDTO dto  = memberMapper.getMember(id);
			mav.addObject("points", dto.getPoints());
		}
		String city = getCity(req.getCookies());
		mav = getWeather(city, mav, resp);
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/weatherChange.do", method = RequestMethod.POST)
	public HashMap<String,Object> weather_ch(String city, HttpServletResponse resp){
		
		HashMap<String,Object>  hs = this_weather(city);
		resp.addCookie(setCity(city));
		return hs;
	}
	
	public String getCity(Cookie[] cookies){
		String city = "";
		try {
			if(cookies != null) {
				for(Cookie cok : cookies) {
					if(cok.getName().trim().equals("city")) {
						city = new String(URLDecoder.decode((cok.getValue()),"utf-8"));
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			return city;
		}
		return city;
	}
	
	public ModelAndView getWeather(String city, ModelAndView mav, HttpServletResponse resp) {
		if(city.trim().equals("")) {
			city = "서울";
			resp.addCookie(setCity(city));
		}
		HashMap<String, Object> hs = this_weather(city);
		mav.addObject("city",hs.get("city"));
	    mav.addObject("weather",hs.get("weather"));
	    mav.addObject("temp",hs.get("temp"));
	    mav.addObject("temp_min", hs.get("temp_min"));
	    mav.addObject("temp_max",hs.get("temp_max"));
	    mav.addObject("icon", hs.get("icon"));
		mav.addObject("city_list", CITY_LIST);
		return mav;
	}

	protected Cookie setCity(String city) {
		try {
			Cookie cookie_city = new Cookie("city", URLEncoder.encode(city,"utf-8"));
			cookie_city.setMaxAge(3*60*60);
			return cookie_city;
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	protected HashMap<String, Object> this_weather(String city) {
		String city_kr = city;
		switch(city) {
		case "서울":
			city = "Seoul";
			break;
		case "인천":
			city = "Incheon";
			break;
		case "춘천":
			city = "Chuncheon";
			break;
		case "청주":
			city = "Cheongju";
			break;
		case "대전":
			city = "Daejeon";
			break;
		case "안동":
			city = "Andong";
			break;
		case "전주":
			city = "Jeonju";
			break;
		case "포항":
			city = "Pohang";
			break;
		case "대구":
			city = "Daegu";
			break;
		case "울산":
			city = "Ulsan";
			break;
		case "부산":
			city = "Busan";
			break;
		case "창원":
			city = "Changwon";
			break;
		case "여수":
			city = "Yeosu";
			break;
		case "광주":
			city = "Gwangju";
			break;
		case "제주":
			city = "Jeju";
			break;
		}
		
		HashMap<String, Object> hs = new HashMap<>();
		try{
          String urlstr = "http://api.openweathermap.org/data/2.5/weather?q="+city+",kr"
            		+"&appid=68935ac7bbc508b481d8f48209ebdca5";
            URL url = new URL(urlstr);
            BufferedReader bf;
            String line;
            String result="";
            
            //날씨 정보
            bf = new BufferedReader(new InputStreamReader(url.openStream()));

            //문자열 변환
            while((line=bf.readLine())!=null){
                result=result.concat(line);
            }

            //문자열을 JSON으로 파싱
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(result);
            
            JSONArray weatherArray = (JSONArray) jsonObj.get("weather");
            JSONObject obj = (JSONObject) weatherArray.get(0);
            
            JSONObject mainArray = (JSONObject) jsonObj.get("main");
            int temp = (int)(Double.parseDouble(mainArray.get("temp").toString()) - 273.15);
            int temp_min= (int)(Double.parseDouble(mainArray.get("temp_min").toString()) - 273.15);
            int temp_max= (int)(Double.parseDouble(mainArray.get("temp_max").toString()) - 273.15);
            
           hs.put("city",  city_kr);
           hs.put("weather",obj.get("main"));
           hs.put("temp",temp);
           hs.put("temp_min",temp_min);
           hs.put("temp_max",temp_max);
           hs.put("icon", obj.get("icon"));
           
        }
		catch(NumberFormatException e){
			e.printStackTrace();
		} 
		catch (IOException e){
			e.printStackTrace();
		}
		catch (ParseException e) {
			e.printStackTrace();
		}
		return hs;
	}
	
	@RequestMapping(value = "/start.do")
	   public ModelAndView calendar_Start(int year, int month) {
	      ModelAndView mav = new ModelAndView("odiga/calendar");
	      Calendar cal = Calendar.getInstance();
	      cal.set(year, month-1, 1);
	      int lastday = cal.getActualMaximum(Calendar.DATE); //마지막 날짜
	      int gong = cal.get(Calendar.DAY_OF_WEEK)-1; //공백
	      
	      int last_mon = month-1;
	      int last_year = year;
	      if(last_mon == 0) {
	         last_year--;
	         last_mon = 12;
	      }else if(last_mon > 12) {
	         last_year++;
	         last_mon = 1;
	      }
	      cal.set(last_year, last_mon-1, 1);
	      int yes_lastday = cal.getActualMaximum(Calendar.DATE);
	      
	      mav.addObject("year", year);
	      mav.addObject("month", month);
	      mav.addObject("gong", gong);
	      mav.addObject("lastday", lastday);
	      mav.addObject("yes_lastday", yes_lastday);
	      return mav;
	   }
	
	@RequestMapping(value = "/end.do")
	   public ModelAndView calendar_End(int year, int month) {
	      ModelAndView mav = new ModelAndView("odiga/calendar");
	      Calendar cal = Calendar.getInstance();
	      cal.set(year, month-1, 1);
	      int lastday = cal.getActualMaximum(Calendar.DATE); //마지막 날짜
	      int gong = cal.get(Calendar.DAY_OF_WEEK)-1; //공백
	      
	      int last_mon = month-1;
	      int last_year = year;
	      if(last_mon == 0) {
	         last_year--;
	         last_mon = 12;
	      }else if(last_mon > 12) {
	         last_year++;
	         last_mon = 1;
	      }
	      cal.set(last_year, last_mon-1, 1);
	      int yes_lastday = cal.getActualMaximum(Calendar.DATE);
	      
	      mav.addObject("year", year);
	      mav.addObject("month", month);
	      mav.addObject("gong", gong);
	      mav.addObject("lastday", lastday);
	      mav.addObject("yes_lastday", yes_lastday);
	      return mav;
	   }

}