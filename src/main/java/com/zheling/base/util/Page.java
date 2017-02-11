package com.zheling.base.util;

import java.util.List;

/**
 * 分页模型类
 * 
 * @author WGJ
 *
 * @param <T>
 */
public class Page<T> {

	// 分页模型在 Request 中的固定名称
	public static final String PAGE_NAME = "page";
	// 每页显示的个数
	public static final int PAGE_SIZE = 20;

	private int pageNo; // 当前页数
	private int totalPageNo; // 总页数
	private int totalCount; // 总个数
	private List<T> results; // 结果集

	public Page(int pageSize, int pageNo, int totalCount) {
		totalPageNo = (totalCount / pageSize)
				+ ((totalCount % pageSize == 0) ? 0 : 1);

		this.pageNo = pageNo;
		if (this.pageNo < 1) {
			this.pageNo = 1;
		}
		if (this.pageNo > totalPageNo) {
			this.pageNo = totalPageNo;
		}

		this.totalCount = totalCount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public int getTotalPageNo() {
		return totalPageNo;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public List<T> getResults() {
		return results;
	}

	public void setResults(List<T> results) {
		this.results = results;
	}

	public boolean isHasPrev() {
		return pageNo > 1;
	}

	public boolean isHasNext() {
		return pageNo < totalPageNo;
	}

	public int getPrev() {
		return pageNo - 1;
	}

	public int getNext() {
		return pageNo + 1;
	}

}