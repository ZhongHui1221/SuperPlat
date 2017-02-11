package com.zheling.base.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.lang3.StringUtils;

/**
 * 数据处理工具类
 * 
 * @author WGJ
 */
public class DataProcessUtil {

	public static String md5(String source) {
		if (StringUtils.isBlank(source)) {
			return null;
		}

		byte[] bytes = source.getBytes();
		char[] characters = new char[] { '0', '1', '2', '3', '4', '5', '6',
				'7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		StringBuilder builder = new StringBuilder();

		try {
			MessageDigest messageDigest = MessageDigest.getInstance("md5");
			byte[] targetArr = messageDigest.digest(bytes);

			for (int i = 0; i < targetArr.length; i++) {
				byte b = targetArr[i];

				int lowNum = b & 15;
				int highNum = (b >> 4) & 15;

				char lowChar = characters[lowNum];
				char highChar = characters[highNum];

				builder.append(highChar).append(lowChar);
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}

}