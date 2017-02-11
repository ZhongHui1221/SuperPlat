package com.zheling.base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 */
public class DateUtil {

	private static final int[] dayArray = { 31, 28, 31, 30, 31, 30, 31, 31, 30,
			31, 30, 31 };

	public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy");
	public static final SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy HH:mm");
	public static final SimpleDateFormat DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy HH:mm:ss");

	public static final SimpleDateFormat ORA_DATE_FORMAT = new SimpleDateFormat(
			"yyyyMMdd");
	public static final SimpleDateFormat ORA_DATE_TIME_FORMAT = new SimpleDateFormat(
			"yyyyMMddHHmm");
	public static final SimpleDateFormat ORA_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"yyyyMMddHHmmss");
	public static final SimpleDateFormat ORA_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"HHmmss");

	public static final SimpleDateFormat CHN_DATE_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd");
	public static final SimpleDateFormat CHN_DATE_TIME_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm");
	public static final SimpleDateFormat CHN_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	private int year;
	private int month;
	private int day;
	private int hour;
	private int minute;
	private int second;

	public DateUtil() {
		today();
	}

	public DateUtil(String inValue) {
		SetDate(inValue);
	}

	DateUtil(long mills) {
		setTimeInMillis(mills);
	}

	DateUtil(int year, int month, int day, int hour, int minute, int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day, hour, minute, second);
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
	}

	public void SetDate(String inValue) {
		if (inValue.length() != 14) {
			for (int i = inValue.length(); i < 14; i++) {
				inValue = inValue + "0";
			}
			System.out.println(inValue);
		}
		try {
			int year = Integer.parseInt(inValue.substring(0, 4));
			int month = Integer.parseInt(inValue.substring(4, 6));
			int day = Integer.parseInt(inValue.substring(6, 8));
			int hour = Integer.parseInt(inValue.substring(8, 10));
			int minute = Integer.parseInt(inValue.substring(10, 12));
			int second = Integer.parseInt(inValue.substring(12));

			Calendar calendar = Calendar.getInstance();
			calendar.set(year, month - 1, day, hour, minute, second);
			this.year = calendar.get(1);
			this.month = (calendar.get(2) + 1);
			this.day = calendar.get(5);
			this.hour = calendar.get(11);
			this.minute = calendar.get(12);
			this.second = calendar.get(13);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	private void today() {
		Calendar calendar = Calendar.getInstance();
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
	}

	public String format(SimpleDateFormat df) {
		Date date = new Date(this.year - 1900, this.month - 1, this.day,
				this.hour, this.minute, this.second);
		return df.format(date);
	}

	public String format2(String strFormat) {
		Date date = new Date(this.year - 1900, this.month - 1, this.day,
				this.hour, this.minute, this.second);
		SimpleDateFormat df = new SimpleDateFormat(strFormat);
		return df.format(date);
	}

	public String format3(String strFormat) {
		Date date = new Date(this.year - 1900, this.month - 1, this.day);
		SimpleDateFormat df = new SimpleDateFormat(strFormat);
		return df.format(date);
	}

	public String toString() {
		return format(CHN_DATE_TIME_EXTENDED_FORMAT);
	}

	public int getDay() {
		return this.day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getHour() {
		return this.hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getMinute() {
		return this.minute;
	}

	public void setMinute(int minute) {
		this.minute = minute;
	}

	public int getMonth() {
		return this.month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getSecond() {
		return this.second;
	}

	public void setSecond(int second) {
		this.second = second;
	}

	public int getYear() {
		return this.year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public long getTimeInMillis() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour,
				this.minute, this.second);
		return calendar.getTime().getTime();
	}

	public void setTimeInMillis(long mills) {
		Date dd = new Date(mills);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dd);
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
	}

	public boolean isLeapYear() {
		return isLeapYear(this.year);
	}

	public boolean isLeapYear(int year) {
		if (year % 400 == 0) {
			return true;
		}
		if (year % 4 == 0) {
			if (year % 100 == 0) {
				return false;
			}
			return true;
		}
		return false;
	}

	public void _add(int years, int months, int days, int hours, int minutes,
			int seconds) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year + years, this.month - 1 + months, this.day
				+ days, this.hour + hours, this.minute + minutes, this.second
				+ seconds);
		setTimeInMillis(calendar.getTime().getTime());
	}

	public void addYear(int years) {
		if ((this.month == 2) && (this.day == 29)) {
			if (isLeapYear(this.year + years)) {
				_add(years, 0, 0, 0, 0, 0);
			} else {
				_add(years, 0, -1, 0, 0, 0);
			}
		} else {
			_add(years, 0, 0, 0, 0, 0);
		}
	}

	public void addMonth(int months) {
		int this_day_end = daysOfMonth();
		int that_day_end = getDayOfMonth(months);
		if (this.day == this_day_end) {
			this.day = that_day_end;
		} else if (this.day > that_day_end) {
			this.day = that_day_end;
		}
		_add(0, months, 0, 0, 0, 0);
	}

	public void addDay(int days) {
		_add(0, 0, days, 0, 0, 0);
	}

	public void addHour(int hours) {
		_add(0, 0, 0, hours, 0, 0);
	}

	public void addMinute(int minutes) {
		_add(0, 0, 0, 0, minutes, 0);
	}

	public void addSecond(int seconds) {
		_add(0, 0, 0, 0, 0, seconds);
	}

	public int daysOfMonth() {
		if ((this.month > 12) || (this.month < 0)) {
			return 0;
		}
		if ((this.month == 2) && (isLeapYear())) {
			return 29;
		}
		return dayArray[(this.month - 1)];
	}

	public int getDayOfMonth(int ms) {
		int yy = ms / 12;
		int mm = ms % 12;
		int year = this.year + yy;
		int month = this.month + mm;
		if (month > 12) {
			month -= 12;
			year++;
		}
		if (month < 1) {
			month += 12;
			year--;
		}
		if ((month == 2) && (isLeapYear(year))) {
			return 29;
		}
		return dayArray[(month - 1)];
	}

	public static boolean isValidDate(String s, SimpleDateFormat dateFormat) {
		try {
			dateFormat.setLenient(false);
			dateFormat.parse(s);
			return true;
		} catch (Exception e) {
		}
		return false;
	}

	public String getCurrentDate(SimpleDateFormat dateFormat) {
		String dateStr = format(dateFormat);
		return dateStr;
	}

	public static long diffSec(DateUtil DateUtil1, DateUtil DateUtil2) {
		return (DateUtil1.getTimeInMillis() - DateUtil2.getTimeInMillis()) / 1000L;
	}

}