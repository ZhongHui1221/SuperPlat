package com.zheling.base.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FloorVo {

	private String id;
	private String text;
	private List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

	public FloorVo() {
		super();
	}

	public FloorVo(String id, String text, List<Map<String, Object>> children) {
		super();
		this.id = id;
		this.text = text;
		this.children = children;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<Map<String, Object>> getChildren() {
		return children;
	}

	public void setChildren(List<Map<String, Object>> children) {
		this.children = children;
	}

}