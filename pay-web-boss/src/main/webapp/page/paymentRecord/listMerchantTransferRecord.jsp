<%
//转账记录 @author
 %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/page/inc/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
%>
<script type="text/javascript" src="js/common.js"></script>
<div class="pageHeader" >
	<form id="pagerForm" onsubmit="return navTabSearch(this);" action="paymentRecord_listMerchantTransferRecord.action" method="post">
	<%@include file="/page/inc/pageForm.jsp"%>
	<div class="searchBar">
		<table class="searchContent" >
			<tr>
				<td>交易流水号：</td>
				<td align="left"><input name="trxNo" type="text" value="${proMap.trxNo}" alt="精确搜索"/></td>
				<td class="lf">创建时间：</td>
				<td align="left">
					<input name="beginDate"  readonly="readonly" value="${proMap.beginDate}" type="text" id="beginDateMemberTransList" style="width: 77px;" class="date"  /> 至 
					<input name="endDate"  readonly="readonly" value="${proMap.endDate}" type="text" class="date" id="endDateMemberTransList" style="width: 77px;" />
				</td>
				<td>收款方账户：</td>
				<td align="left"><input name="sourceLoginName" type="text" value="${proMap.sourceLoginName}" alt="精确搜索"/></td>
			</tr>
			<tr>
				<td>交易状态：</td>
				<td align="left">
					<select name="status">
						<option value="">--请选择--</option>
						<c:forEach items="${paymentRecordStatus }" var="model">
							<option value="${model.value }"
							<c:if test="${proMap.status eq model.value}">selected="selected"</c:if>>${model.desc }</option>
						</c:forEach>
					</select>
				</td>
				<td>付款方账户：</td>
				<td align="left"><input name="targetLoginName" type="text" value="${proMap.targetLoginName}" alt="精确搜索"/></td>
				<td colspan="2">
					<div class="subBar" style="float:right;">
						<ul>
							<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
	</div>
	</form>
</div>
<div class="pageContent">
<table class="table" targetType="navTab" asc="asc" desc="desc" width="100%" nowrapTD="false" layoutH="133">
		<thead>
			<tr>
				<th>创建时间</th>
				<th>交易流水号</th>
				<th>付款方账户</th>
				<th>付款方姓名</th>
				<th>收款方账户</th>
				<th>收款方名称</th>
				<th>订单金额</th>
				<th>手续费</th>
				<th>转账说明</th>
				<th>交易状态</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="recordList" status="st">
				<tr target="sid" rel="${Id}">
					<td><fmt:formatDate value="${createTime}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${trxNo}</td>
					<td>${targetLoginName}</td>
					<td>${targetName }</td>
					<td>${sourceLoginName}</td>
					<td>${sourceName }</td>
					<td><fmt:formatNumber value="${amount}" pattern="0.00"></fmt:formatNumber>
					<td><fmt:formatNumber value="${targetFee}" pattern="0.00"></fmt:formatNumber>
					</td>
					 <td>${remark }</td>
					<td>
						<c:forEach items="${paymentRecordStatus }" var="v">
							<c:if test="${status eq v.value }">${v.desc}</c:if>
						</c:forEach>
				 	</tr>
				</s:iterator>
		</tbody>
	</table>
    <!-- 分页条 -->
    <%@include file="/page/inc/pageBar.jsp"%>
</div>
<script>
	$(document).ready(function(){
			$("#sreachKeys").bind("keyup", function(event){if (event.keyCode==13) searchDatas();});
			$("#sreachNames").bind("keyup", function(event){if (event.keyCode==13) searchDatas();});
	});
	
	function searchDatas(){
		$("#pagerForm").submit();
	}
	
	
	function selectDateMemberTransList(str, obj) {
	    var now = new Date(); //获取当前时间
	    var year = now.getFullYear(); //获取当前日期的年份部分
	    var month = now.getMonth() + 1 +""; //获取当前日期的月份部分
	    var day = now.getDate() +""; //获取当前日期的天数部分
	    if(day.length==1){
	    	day="0"+day;
	    }
	    //获取当前月份包含的天数
	    var nowdays = new Date(year, month, 0).getDate();
	    var lastMonth = month - 1+"";
	    var lastMonthdays = new Date(year, lastMonth, 0).getDate() +"";
	    if(month.length==1){
	    	month="0"+month;
	    }
	    if(lastMonth.length==1){
	    	lastMonth="0"+lastMonth;
	    }
	    if(lastMonthdays.length==1){
	    	lastMonthdays="0"+lastMonthdays;
	    }
	    var startTime = "";
	    var endTime = "";
	    switch (str) {
	        case "toDay":
	        	startTime = year + "-" + month + "-" + day;
	        	endTime = year + "-" + month + "-" + day;
	            break;
	        case "lastMonth":
	            if (lastMonth == 0) { lastMonth = 12; year = year - 1; }
	            startTime = year + "-" + lastMonth + "-01";
	            endTime = year + "-" + lastMonth + "-" + lastMonthdays;
	            break;
	        case "currentMonth":
	            startTime = year + "-" + month + "-01";
	            //endTime = year + "-" + month + "-" + day;
	            endTime = year + "-" + month + "-" + nowdays;
	            break;
	        case "lastYear":
	            startTime = (year - 1) + "-01-01";
	            endTime = (year - 1) + "-12-31";
	            break;
	        case "currentYear":
	            startTime = year + "-01-01";
	            endTime = year + "-12-31";
	            break;
	    }
	    $("#beginDateMemberTransList").val(startTime);
	    $("#endDateMemberTransList").val(endTime);

	}

	// 清空表单
	function clearFormMemberTransList(){
		$(':input',"form[action='paymentRecord_listMerchantTransferRecord.action']")  
		 .not(':button, :submit, :reset, :hidden')  
		 .val('')  
		 .removeAttr('checked')  
		 .removeAttr('selected');  
	}
</script>