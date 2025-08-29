package com.wipro.eb.bean;

public class EBConsumerBean {
	private String ConsumerName;
	private String ConsumerNumber;
	private int units;
	private double TotalAmount;
	
	public String getConsumerName() {
		return ConsumerName;
	}
	public void setConsumerName(String ConsumerName) {
		this.ConsumerName = ConsumerName;
	}
	
	public String getConsumerNumber() {
		return ConsumerNumber;
	}
	public void setConsumerNumber(String ConsumerNumber) {
		this.ConsumerNumber = ConsumerNumber;
	}
	
	public int getunits() {
		return units;
	}
	public void setunits(int units) {
		this.units = units;
	}
	
	public double getTotalAmount() {
		return TotalAmount;
	}
	public void setTotalAmount(double TotalAmount) {
		this.TotalAmount = TotalAmount;
	}
}
