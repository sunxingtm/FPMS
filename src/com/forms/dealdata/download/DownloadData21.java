package com.forms.dealdata.download;

import org.springframework.stereotype.Component;

@Component
public class DownloadData21 extends DownloadData {
	
	@Override
	public void dealFile(String batchNo, String tradeDate, String tradeType)
			throws Exception {
		super.dealFile(batchNo, tradeDate, tradeType);
		//校验文件
		checkResultData(batchNo, tradeDate, tradeType);
	}
	
}
