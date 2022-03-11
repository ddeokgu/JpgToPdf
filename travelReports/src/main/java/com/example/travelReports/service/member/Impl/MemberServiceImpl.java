package com.example.travelReports.service.member.Impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.travelReports.mapper.member.MemberMapper;
import com.example.travelReports.service.member.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberMapper memberMapper;
	
	public void memberRegist(Map paramMap) {
		memberMapper.memberRegist(paramMap);
	}

}
