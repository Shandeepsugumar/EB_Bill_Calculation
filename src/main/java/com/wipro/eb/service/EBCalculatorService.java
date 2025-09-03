package com.wipro.eb.service;
import com.wipro.eb.bean.*;
import com.wipro.eb.dao.*;
import com.wipro.eb.util.*;

public class EBCalculatorService {

    public double calculateBill(EBConsumerBean bean) throws InvalidUnitException {
        int units = bean.getUnits();   // make sure EBConsumerBean has getUnits()
        double totalAmount = 0;

        if (units <= 10) {
            throw new InvalidUnitException();
        }

        if (units <= 100) {
            totalAmount = 0;
        } else if (units <= 300) {
            totalAmount = (units - 100) * 2.5;
        } else if (units <= 500) {
            totalAmount = (200 * 2.5) + (units - 300) * 4;
        } else {
            totalAmount = (200 * 2.5) + (200 * 4) + (units - 500) * 16;
        }

        bean.setTotalAmount(totalAmount);

        // Save into DB but don’t mix with return
        EBDao dao = new EBDao();
        dao.saveBill(bean);

        return totalAmount; // ✅ returns double
    }
}
