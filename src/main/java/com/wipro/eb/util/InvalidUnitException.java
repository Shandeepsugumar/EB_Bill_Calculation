package com.wipro.eb.util;

public class InvalidUnitException extends Exception {
	@Override
	public String toString() {
		return "InvalidUnitException: units Cannot be less then or equal to 10!";
		
	}
}
