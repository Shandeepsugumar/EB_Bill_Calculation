package com.wipro.eb.service;
import com.wipro.eb.bean.*;
import com.wipro.eb.dao.*;
import com.wipro.eb.util.*;

public class EBCalculatorService {
	public String calculateBill(EBConsumerBean bean) throws InvalidUnitException{
		int units = bean.getunits();
		double TotalAmount = 0;
		
		if (units<=10) throw new InvalidUnitException();
		
		if (units<=100) TotalAmount = 0;
		else if (units<=300) TotalAmount = (units - 100) * 2.5;
		else if (units<=500) TotalAmount = (200 * 2.5) + (units - 300) * 4;
		else TotalAmount = (200 * 2.5) + (250 * 4) + (units - 500) * 16;
		
		bean.setTotalAmount(TotalAmount);
		
		EBDao dao = new EBDao();
		return dao.saveBill(bean) + " | Bill Amount : Rs." + TotalAmount;
	}
}
