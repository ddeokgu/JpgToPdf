package com.example.travelReports.controller.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.travelReports.common.model.JsonResponse;
import com.example.travelReports.service.member.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@ResponseBody
	@RequestMapping("regist.do")
	public Map regist(@RequestParam Map paramMap) {
		System.err.println("params ==" + paramMap);
		String pwd = (String) paramMap.get("member_pwd");
		paramMap.put("member_pwd", pwd != null ? passwordEncoder.encode(String.valueOf(pwd)) :null);
		paramMap.put("member_type", "U");
		memberService.memberRegist(paramMap);
		return JsonResponse.asSuccess();
	}
	
	

}

