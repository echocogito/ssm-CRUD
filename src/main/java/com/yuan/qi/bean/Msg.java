package com.yuan.qi.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	private String code;
	private String msg;
	
	private Map<String, Object> extend = new HashMap();
	
	public static Msg success() {
		Msg result = new Msg();
		result.setCode("100");
		result.setMsg("请求成功");
		return result;
	}
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode("120");
		result.setMsg("请求失败");
		return result;
	}
	
	public Msg add(String key, Object o) {
		this.getExtend().put(key, o);
		return this;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
