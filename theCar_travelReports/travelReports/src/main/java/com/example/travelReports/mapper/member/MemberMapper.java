package com.example.travelReports.mapper.member;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MemberMapper {
	
	public void memberRegist(Map paramMap);
	
}
