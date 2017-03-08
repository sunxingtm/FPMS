package com.forms.prms.web.export.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.forms.platform.core.logger.CommonLogger;
import com.forms.platform.excel.exports.ExcelExportUtility;
import com.forms.platform.excel.exports.JxlsExcelExporter;
import com.forms.platform.excel.exports.SimplifyBatchExcelExporter;
import com.forms.platform.excel.exports.inter.IExportDataDeal;
import com.forms.prms.tool.exceltool.domain.CommonExcelDealBean;
import com.forms.prms.web.contract.query.service.ContractQueryService;
import com.forms.prms.web.pay.orderquery.domain.OrderQueryBean;
import com.forms.prms.web.pay.orderquery.service.OrderQueryService;
import com.forms.prms.web.pay.payquery.domain.PayQueryBean;
import com.forms.prms.web.pay.payquery.service.PayQueryService;

public class PayExport implements IExportDataDeal{

	PayQueryService es = PayQueryService.getInstance();
	ContractQueryService excelDealService = ContractQueryService.getInstance(); // 用于更新导出任务结果状态和导出备注

	@Override
	public void getSimpleExcelData(String taskId, Map params,
			SimplifyBatchExcelExporter excelExporter) throws Exception {
		boolean exportSucFlag = (Boolean) params.get("exportSucFlag");
		String exportMemo = "";

		Map<String, Object> beansMap = new HashMap<String, Object>();
		// 获取方法调用的接收参数
 		String cntNum = (String) params.get("cntNum");
 		String cntType = (String) params.get("cntType");
 		String payId = (String) params.get("payId");
 		String invoiceId = (String) params.get("invoiceId");
 		String providerName = (String) params.get("providerName");
 		String befDate = (String) params.get("befDate");
 		String aftDate = (String) params.get("aftDate");
 		String payDataFlag = (String) params.get("payDataFlag");
 		String dataFlagInvoice = (String) params.get("dataFlagInvoice");
 		String dataFlagPay = (String) params.get("dataFlagPay");
 		String projName = (String) params.get("projName");
 		String conCglCode = (String) params.get("conCglCode");
 		String org1Code = (String) params.get("org1Code");
 		String org2Code = (String) params.get("org2Code");
 		String orgFlag = (String) params.get("orgFlag");
 		String dutyCode = (String) params.get("instDutyCode");
 		
 		PayQueryBean bean = new PayQueryBean();
 		
 		bean.setCntType(cntType);
 		bean.setPayId(payId);
 		bean.setCntNum(cntNum);
 		bean.setInvoiceId(invoiceId);
 		bean.setProviderName(providerName);
 		bean.setBefDate(befDate);
 		bean.setAftDate(aftDate);
 		bean.setPayDataFlag(payDataFlag);
 		bean.setDataFlagInvoice(dataFlagInvoice);
 		bean.setDataFlagPay(dataFlagPay);
 		bean.setProjName(projName);
 		bean.setConCglCode(conCglCode);
 		bean.setOrg1Code(org1Code);
 		bean.setOrg2Code(org2Code);
 		bean.setOrgFlag(orgFlag);
 		bean.setDutyCode(dutyCode);
		// //插入excel数据内容
		try {
			List<PayQueryBean> projects = new ArrayList<PayQueryBean>();
			bean.setFlag("1");
			projects = es.exportExcute(bean);
			beansMap.put("0", projects);
			exportSucFlag = true;
			exportMemo = "处理成功，可下载";
			//增加一条汇总数据
		} catch (Exception e) {
			exportMemo = "【处理失败】， ：" ;
			exportSucFlag = false;
			CommonLogger.error("数据导出时往excel里插入数据失败" + e.getMessage()
					+ "ExportExcel,getSimpleExcelData");
			e.printStackTrace();
		}
		try {
			// 可按查找数据量进行分段加载
			ExcelExportUtility.loadExcelData(beansMap, excelExporter);
		} catch (Exception e) {
			exportSucFlag = false;
			exportMemo = "【处理失败】，";
			e.printStackTrace();
		} finally {
			params.put("exportSucFlag", exportSucFlag);
			params.put("exportMemo", exportMemo);
		}

	}

	@Override
	public void start(String taskId, Map params) throws Exception {
		boolean exportSucFlag = false; // Excel导出操作是否成功标识
		params.put("exportSucFlag", exportSucFlag);
	}

	@Override
	public void end(String taskId, Map params) throws Exception {
		CommonExcelDealBean bean = new CommonExcelDealBean();
		bean.setTaskId(taskId);
		if ((Boolean) params.get("exportSucFlag")) {
			// 成功
			bean.setDataFlag("03");
		} else {
			// 失败
			bean.setDataFlag("02");
		}
		bean.setProcMemo((String) params.get("exportMemo"));
		excelDealService.updateExcelResult(bean);
	}

	/**
	 * 公共方法：批量更改Excel的头部标题 目的：根据配置文件的键值对更改Excel的标题
	 * 
	 * @param headStr
	 * @param updateInfoList
	 */
	public static void addUpdateExcelHeader(Map<String, String> headStr,
			List<String[]> updateInfoList) {
		for (int i = 0; i < updateInfoList.size(); i++) {
			headStr.put(updateInfoList.get(i)[0], updateInfoList.get(i)[1]);
		}
	}

	@Override
	public void getJxlExcelData(String taskId, Map params,
			JxlsExcelExporter jxlExporter) throws Exception {
		// TODO Auto-generated method stub

	}

}
