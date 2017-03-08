<%@page import="com.forms.platform.web.WebUtils"%>
<%@page import="com.forms.platform.web.consts.WebConsts"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.formssi.com/taglibs/froms" prefix="forms" %>
<%@ taglib uri="/platform-tags" prefix="p" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单查询</title>
<script>
function pageInit()
{   
	App.jqueryAutocomplete();
	$("#cntType").combobox();
	$( "#payDate" ).datepicker({
		changeMonth: true,
		changeYear: true,
	    dateFormat:"yy-mm-dd",
	});
}
function resetAll(){
	$(":text").val("");
	$("select").val("");
	$("select").each(function(){
		var id = $(this).attr("id");
		if(id!=""){
			var year = $("#"+id+" option:first").text();
			$(this).val(year);
			 $(this).next().val(year) ;
		}
		
	});
}
//得到详细信息
function showDetail(orderId) 
{  
	var form = $("#tempForm");
 	$("#tempForm #orderId").val(orderId);
 	//alert($("#id").val());
 	form.attr('action', '<%=request.getContextPath()%>/pay/ordercheck/orderInfo.do?<%=WebConsts.FUNC_ID_KEY%>=03070401');
	App.submit(form);
}
</script>
</head>
<body>
<p:authFunc funcArray="030704"/>
<form  method="post" id="tempForm">
	<p:token/>
	<table id="condition">
		<tr class="collspan-control">
			<th colspan="4">
				订单查询
			</th>
		</tr>
		<tr>
			<td class="tdLeft">订单号</td>
			<td class="tdRight">
				<input type="text" id="orderId" name="orderId" value="${selectInfo.orderId}" class="base-input-text" maxlength="20"/>
			</td>
			<td class="tdLeft">采集编号</td>
			<td class="tdRight">
            	<input type="text" id="stockNum" name="stockNum" value="${selectInfo.stockNum}" class="base-input-text" maxlength="100" />
			</td>
		</tr>
		<tr>
			<td class="tdLeft">合同号</td>
			<td class="tdRight">
				<input type="text" id="cntNum" name="cntNum" value="${selectInfo.cntNum}" class="base-input-text"  maxlength="80"/>	
			</td>
			<td class="tdLeft">采购部门</td>
			<td class="tdRight">
				<forms:OrgSelPlugin     jsVarGetValue="orderDutyCode"   ableQuery="true" rootLevel="0" initValue="${selectInfo.orderDutyCode}"/>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<p:button funcId="030704" value="查询"/> 
				<input type="button" value="重置" onclick="resetAll();">
			</td>
		</tr>
	</table>
	<br/>
<div id="tabs" style="border: 0;">
	<div id="tabs-1" style="padding: 0;">
		<table class="tableList">
			<tr>    
			 		<th width="15%">订单号</th>
					<th width="15%">采集编号</th>
					<th width="20%">合同号</th>
					<th width="15%">采购部门</th>
					<th width="10%">状态</th>
					<th width="8%">操作</th>
			</tr>
			 <c:forEach items="${lists}" var="sedList">
				<tr onmouseover="setTrBgClass(this, 'trOnOver2');" onmouseout="setTrBgClass(this, 'trOther');">
					<td class="tdc" ><c:out value="${sedList.orderId}"></c:out></td>
					<td ><c:out value="${sedList.stockNum}"></c:out></td>
					<td class="tdc" ><c:out value="${sedList.cntNum}"/></td>
					<td ><c:out value="${sedList.orderDutyCodeName}"/></td>
					<td ><c:out value="${sedList.dataFlagName}"/></td>
					<td>
							<div class="update"   style="padding-left: 5px">
					   	    	 <a href="#" onclick="showDetail('${sedList.orderId}')" title="复核"></a>
							</div>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty lists}">
					<tr><td style="text-align: center;" colspan="6"><span class="red">没有找到相关信息</span></td></tr>
			</c:if>
		</table>
	</div>
</div>
</form>
<p:page />
</body>
</html>