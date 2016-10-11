<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="com.dt.esignage.webserver.utils.CommonUtils"%>
<%@ page import="java.util.Locale"%>
<%@ page import="org.apache.struts.Globals"%>
<%@ page import="com.dt.esignage.webserver.system.VersionCheckUtils"%>
<%@ page import="com.dt.esignage.webserver.secret.ActionSecretDefine"%>
<%@ page import="com.dt.esignage.webserver.model.domain.Site"%>
<%@ page import="com.dt.esignage.webserver.secret.UserInfoBean"%>
<%@ page import="com.dt.esignage.webserver.utils.ActionConstantDefine"%>
<%@ page import="com.dt.common.KeyChecker"%>
<%@ page import="com.dt.esignage.webserver.system.VersionCheckUtils"%>

<%
long lEdition = -1;
boolean bIsTrial = false;
String strEditionInfor = VersionCheckUtils.getDBEdition();
String strVersion = VersionCheckUtils.getDBVersionForJSP();
KeyChecker keyChecker = new KeyChecker();
if (keyChecker.IsValid(strEditionInfor)) {
	lEdition = keyChecker.GetEdition();
	bIsTrial = keyChecker.IsTrial();
}
boolean isUnknowEdition = false;
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>WebDT Content Manager <%if(lEdition == ActionConstantDefine.WORKGROUPEDITION){ %>
			<bean:message key="esignage.contentserver.jsp.editioninfo.workgroupedition" />
			<%}else if(lEdition == ActionConstantDefine.ENTERPRISEEDITION){ %>
			<bean:message key="esignage.contentserver.jsp.editioninfo.enterpriseedition" />
			<%} else if(lEdition == ActionConstantDefine.ASPEDITION){ %>
			<bean:message key="esignage.contentserver.jsp.editioninfo.aspedition" />
			<%}else{ isUnknowEdition = true; %>
			<bean:message key="esignage.contentserver.jsp.editioninfo.unkownedition" />
			<%} %><bean:message key="esignage.contentserver.jsp.index.version" />:&nbsp;
			<%=strVersion%>&nbsp;<%=ActionConstantDefine.BUILT_INFO%></title>

<%
	String languageStr = "en_us";
	Locale aLocale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
	if (null != aLocale) {
		languageStr = aLocale.toString();

	}
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/jquery/jquery.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/jquery/jquery-cookie.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script>

<script type="text/javascript">
	/**
	* NOTE: Update this file must update mainWrapper.jsp, trigger the jsp compile these 2 files. 
	*/
	
	/**
	* For creating the css object. 
	*/
	function createCssObject( cssSrc ){
		console.log("createCssObject!cssSrc="+cssSrc);
		var event = new Event('load');
		//Script object 
		var newCss = document.createElement('link');
		newCss.href = cssSrc;
		newCss.rel  = 'stylesheet';
		newCss.type = 'text/css';
		//link.href = 'http://website.com/css/stylesheet.css';
		newCss.addEventListener( event, postLoadFunction );   
		document.documentElement.firstChild.appendChild(newCss);
		return newCss;
	}
	
	
	//@TODO May need a function for replacing the css object.
	
	/**
	* For creating the script object. 
	*/
	function createScriptObject( scriptSrc ){
		console.log("createScriptObject!scriptSrc="+scriptSrc);
		var event = new Event('load');
		//Script object 
		var newScript = document.createElement('script');
		newScript.src = scriptSrc;
		newScript.addEventListener( event, postLoadFunction );   
		document.documentElement.firstChild.appendChild(newScript);
		return newScript;
	}
	
	/**
	* Replace the script object.
	*/
	function replaceScriptObject(newScript, scriptSrc, originalScript){
		var event = new Event('load');
		//Script object 
		newScript = document.createElement('script');
		newScript.src = scriptSrc;
		event.data =  scriptSrc;
		document.documentElement.firstChild.replaceChild(newScript, originalScript);       
		newScript.addEventListener(event, postLoadFunction);
		return newScript;
	}
	
	/**
	* Post load the event after create or replace the script object.
	*/
	function postLoadFunction(event){
		console.log("postLoadFunction!!!event.data="+event.data);
	}
	
	var ctxPath = "<%=request.getContextPath()%>";
	
	console.log("ctxPath=" + ctxPath);
	
	//var mainJsObj = createScriptObject( ctxPath + "/modules/framework/js/main.js");
	
	//window.main = createScriptObject(window.main,"../js/main.js");
	/**
	* NOTE: The sequence is very important. Change the sequence may cause the javascript error.
	*/
	window.onload = function() {
		
		//window.jqueryJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.dhtmlxJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlx/dhtmlx.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.monitorScheduleDialogJs = createScriptObject("/modules/schedule/dialog/publishMonitorDialog/js/monitorScheduleDialog.js");
		
		window.dhtmlxSchedulerJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/dhtmlxscheduler.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		//window.ext_minicalJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_minical.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ext_multiselectJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multiselect.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ext_multisourceJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multisource.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ext_collisionJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_collision.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ext_agenda_viewJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_agenda_view.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.propertyJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/property.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.dhtmlscheduler_overwriteJs = createScriptObject("<%=request.getContextPath()%>/modules/schedule/js/dhtmlscheduler_overwrite.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		//Original script & css on mainWrapper.jsp
		window.resumeUploaderJs = createScriptObject("/modules/common/uploader/js/ResumeUploader.js");
		window.html5UploaderJs = createScriptObject("/modules/common/uploader/js/HTML5Uploader.js");
		
		window.processDivJs = createScriptObject("/modules/framework/js/processDiv.js");
		
		window.uploadMonitorDialogJs = createScriptObject("<%=request.getContextPath()%>/modules/common/dialog/uploadmonitor/js/UploadMonitorDialog.js");
		window.previewDialogJs = createScriptObject("<%=request.getContextPath()%>/modules/common/dialog/previewWizard/js/PreviewDialog.js");
		window.privilegeDialogJs = createScriptObject("<%=request.getContextPath()%>/modules/privilege/js/PrivilegeDialog.js");
		window.onlineTemplateMonitorDialogJs = createScriptObject("<%=request.getContextPath()%>/modules/common/dialog/onlineTemplate/js/onlineTemplateMonitorDialog.js");
		
		//window.mainJs = createScriptObject("/modules/framework/js/main.js");
		
		window.dropdownCss = createCssObject("/js/dropdown/dropdown.css");
		window.dropdownJs = createScriptObject("/js/dropdown/dropdown.js");
		
		window.formUploaderJs = createScriptObject("/modules/common/uploader/js/FormUploader.js");
		
		window.mediaUploadErrJs = createScriptObject("/modules/common/uploader/js/mediaUploadErr.js");
		//window.monitorScheduleDialogJs = createScriptObject("/modules/schedule/dialog/publishMonitorDialog/js/monitorScheduleDialog.js");
		
		window.uploaderAreaJs = createScriptObject("/modules/common/uploader/js/uploaderArea.js");
		//end original script & css on mainWrapper.jsp 
		
		
		//Original script & css on mainCommon.jsp
		window.jquery_ui_1_8_16_customCss = createCssObject("<%=request.getContextPath()%>/css/cupertino/jquery-ui-1.8.16.custom.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jquery_ui_timepicker_addonCss = createCssObject("<%=request.getContextPath()%>/css/cupertino/jquery-ui-timepicker-addon.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dt_jquery_uiCss = createCssObject("<%=request.getContextPath()%>/css/dt_jquery-ui.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dt_widgetCss = createCssObject("<%=request.getContextPath()%>/css/dt-widget.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.dt_widgetCss = createCssObject("<%=request.getContextPath()%>/css/dt-widget.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		<!-- Includes DHTMX CSS start -->
		window.dhtmlCss = createCssObject("<%=request.getContextPath()%>/js/common/dhtmlx/dhtmlx.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dhtmlxcalendar_dhx_skyblueCss = createCssObject("<%=request.getContextPath()%>/js/common/dhtmlx/skins/dhtmlxcalendar_dhx_skyblue.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ftypesCss = createCssObject("<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dhtmlxscheduler_glossyCss = createCssObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/dhtmlxscheduler_glossy.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dt_dhtmlxschedulerCss = createCssObject("<%=request.getContextPath()%>/css/dt_dhtmlxscheduler.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		<!-- Includes DHTMX scripts end -->
		window.baseCss = createCssObject("<%=request.getContextPath()%>/css/base.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.mainCss = createCssObject("<%=request.getContextPath()%>/css/main.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtreeCss = createCssObject("<%=request.getContextPath()%>/css/dtree.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtCss = createCssObject("<%=request.getContextPath()%>/css/old/dt.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		<!--jquery layout-->
		window.layout_default_latestCss = createCssObject("<%=request.getContextPath()%>/css/layout-default-latest.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dhtmlxgrid_dhx_deluxeCss = createCssObject("<%=request.getContextPath()%>/css/dhtmlxgrid_dhx_deluxe.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.momentJs = createScriptObject("<%=request.getContextPath()%>/js/common/moment.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dateJs = createScriptObject("<%=request.getContextPath()%>/js/utils/date.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.baseJs = createScriptObject("<%=request.getContextPath()%>/js/common/base.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.json2Js = createScriptObject("<%=request.getContextPath()%>/js/utils/json2.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.objectCloneJs = createScriptObject("<%=request.getContextPath()%>/js/common/objectClone.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		//window.dhtmlxSchedulerJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/dhtmlxscheduler.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		<!-- Includes DHTMX scheduler scripts start -->
		//window.dhtmlxJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlx/dhtmlx.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ftypesJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dhtmlscheduler_overwriteJs = createScriptObject("<%=request.getContextPath()%>/modules/schedule/js/dhtmlscheduler_overwrite.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ext_minicalJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_minical.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ext_multiselectJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multiselect.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ext_multisourceJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multisource.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ext_collisionJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_collision.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.ext_agenda_viewJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_agenda_view.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.propertyJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlxscheduler/property.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.ftypesJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		<!-- Includes DHTMX scripts end -->
		
		window.log4javascriptJs = createScriptObject("<%=request.getContextPath()%>/js/common/log4javascript.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.printfJs = createScriptObject("<%=request.getContextPath()%>/js/common/printf.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.scriptCssLoaderMinJs = createScriptObject("<%=request.getContextPath()%>/js/common/ScriptCssLoader-min.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.utilsJs = createScriptObject("<%=request.getContextPath()%>/js/common/utils.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtdebugJs = createScriptObject("<%=request.getContextPath()%>/js/common/dtdebug.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.checkinputJs = createScriptObject("<%=request.getContextPath()%>/js/common/checkinput.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.randomUUIDJs = createScriptObject("<%=request.getContextPath()%>/js/common/randomUUID.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.jqueryJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		//window.jqueryCookieJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery-cookie.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtCookieUtilJs = createScriptObject("<%=request.getContextPath()%>/js/utils/DTCookieUtil.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryHotkeysJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.hotkeys.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.commonAjaxJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/common_ajax.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryDataTablesJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.dataTables.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jquerySkygqOneDblClick_1_1_Js = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.skygqOneDblClick.1.1.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryUiCustomJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery-ui-custom.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryLayoutLatestJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery.layout-latest.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryUiSliderAccessJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery-ui-sliderAccess.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.jqueryUiTimepickerAddonJs = createScriptObject("<%=request.getContextPath()%>/js/common/jquery/jquery-ui-timepicker-addon.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.prototypeJs = createScriptObject("<%=request.getContextPath()%>/js/common/prototype/prototype.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtJs = createScriptObject("<%=request.getContextPath()%>/js/dt/dt.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.requestJs = createScriptObject("<%=request.getContextPath()%>/js/dt/http/Request.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.cookieJs = createScriptObject("<%=request.getContextPath()%>/js/dt/http/Cookie.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.attributeJs = createScriptObject("<%=request.getContextPath()%>/js/dt/util/Attribute.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.dtMapJs = createScriptObject("<%=request.getContextPath()%>/js/dt/util/Map.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.utilMapJs = createScriptObject("<%=request.getContextPath()%>/js/utils/map.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.constantsJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/Constants.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeFunctionJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeFunction.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeActionJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeAction.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeOnErrorJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeOnError.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeCheckBoxJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeCheckBox.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeIconJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeIcon.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.nodeStyleJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/NodeStyle.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeAspectJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeAspect.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeNodeJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeNode.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeNodeHTMLJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeNodeHTML.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeContextJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeContext.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeViewJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeView.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeAPIJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeAPI.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeUtilJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeUtil.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.treeEventJs = createScriptObject("<%=request.getContextPath()%>/js/dt/widget/tree/TreeEvent.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.taskTypeDefineJs = createScriptObject("<%=request.getContextPath()%>/modules/framework/js/task_type_define.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		
		window.ftypesJs = createScriptObject("<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>");
		window.mainJs = createScriptObject("/modules/framework/js/main.js");
	};
	
	jQuery(document).on("DOMContentLoaded", function (event) {
		jQuery.noConflict();
		jQuery.ignoreRunInnerHTMLScript = true;
		var cookieValue = jQuery.cookie("DTUI_dhx_imgs");
		if (null == cookieValue) {
			cookieValue = "/js/common/dhtmlx/imgs/";
		}
		dhtmlx.image_path = cookieValue;
		jQuery.cookie("DTUI_dhx_imgs", cookieValue, {
			expires : 30,
			path : "/"
		});
		cookieValue = jQuery.cookie("DTUI_dhx_skin");
		if (null == cookieValue) {
			cookieValue = "dhx_deluxe001";
		}
		dhtmlx.skin = cookieValue;

		jQuery.cookie("DTUI_dhx_skin", cookieValue, {
			expires : 30,
			path : "/"
		});
	});
</script>
<!--link
	href="<%=request.getContextPath()%>/css/cupertino/jquery-ui-1.8.16.custom.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link
	href="<%=request.getContextPath()%>/css/cupertino/jquery-ui-timepicker-addon.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->

<!--link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/dt_jquery-ui.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>" /-->

<!--link
	href="<%=request.getContextPath()%>/css/dt-widget.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->

<!-- Includes DHTMX CSS start -->
<!--link
	href="<%=request.getContextPath()%>/js/common/dhtmlx/dhtmlx.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/common/dhtmlx/skins/dhtmlxcalendar_dhx_skyblue.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>" /-->
<!--link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/dt_dhtmlxcalendar.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>" /-->

<!--link
	href="<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/dhtmlxscheduler_glossy.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>" /-->
<!--link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/dt_dhtmlxscheduler.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>" /-->
<!-- Includes DHTMX scripts end -->

<!--link
	href="<%=request.getContextPath()%>/css/base.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link
	href="<%=request.getContextPath()%>/css/main.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link
	href="<%=request.getContextPath()%>/css/dtree.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--link
	href="<%=request.getContextPath()%>/css/old/dt.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->

<!--jquery layout-->
<!--link
	href="<%=request.getContextPath()%>/css/layout-default-latest.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->

<!--link
	href="<%=request.getContextPath()%>/css/dhtmlxgrid_dhx_deluxe.css?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	rel="stylesheet" type="text/css" /-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/moment.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/utils/date.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
	
<script type="text/javascript">
    window.onbeforeunload = function() { return "You work will be lost."; };
	window.context_path = "<%=request.getContextPath()%>";
	window.context_basePath = "<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath() %>";
	window.wcm_version = "<%=VersionCheckUtils.getDBBuildNum()%>";
	window.jsessionid="<%=session.getId()%>";
	window.language = "<%=languageStr%>";
	window.timezoneOffset = new Date().getTimezoneOffset() * 60000;
	window.ui_options = {};
</script>
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/base.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->

<%@ include file="./messages.jsp"%>

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/utils/json2.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"
	
</script-->

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/objectClone.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->


<!-- Includes DHTMX scheduler scripts start -->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/dhtmlxscheduler.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>">
	
</script-->

<!-- Includes DHTMX scheduler scripts end  -->

<!-- Includes DHTMX scripts start -->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlx/dhtmlx.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlx/types/ftypes.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/modules/schedule/js/dhtmlscheduler_overwrite.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_minical.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multiselect.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_multisource.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_collision.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/ext/ext_agenda_view.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dhtmlxscheduler/property.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->

<!-- Includes DHTMX scripts end -->

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/log4javascript.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/printf.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/ScriptCssLoader-min.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/utils.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/dtdebug.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/checkinput.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/randomUUID.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery-cookie.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/utils/DTCookieUtil.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery.hotkeys.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/common_ajax.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery.dataTables.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery.skygqOneDblClick.1.1.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<script type="text/javascript">
	//Move to onload
	/*
	on(document, "DOMContentLoaded", function(event) {
		jQuery.noConflict();
		jQuery.ignoreRunInnerHTMLScript = true;
		var cookieValue = jQuery.cookie("DTUI_dhx_imgs");
		if (null == cookieValue) {
			cookieValue = "/js/common/dhtmlx/imgs/";
		}
		dhtmlx.image_path = cookieValue;
		jQuery.cookie("DTUI_dhx_imgs", cookieValue, {
			expires : 30,
			path : "/"
		});
		cookieValue = jQuery.cookie("DTUI_dhx_skin");
		if (null == cookieValue) {
			cookieValue = "dhx_deluxe001";
		}
		dhtmlx.skin = cookieValue;

		jQuery.cookie("DTUI_dhx_skin", cookieValue, {
			expires : 30,
			path : "/"
		});
	});
	*/
</script>

<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery-ui-custom.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery.layout-latest.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery-ui-sliderAccess.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/jquery/jquery-ui-timepicker-addon.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<script type="text/javascript">

	/* Simplified Chinese translation for the jQuery Timepicker Addon /
	 / Written by Will Lu */
	 // move to onload
	(function($) {
		$.timepicker.regional['default'] = {
			timeOnlyTitle : '<bean:message key="timepicker.js.selecttime" />',
			timeText : '<bean:message key="esignage.contentserver.jsp.patch.dispatch2player.install.time" />',
			hourText : '<bean:message key="timepicker.js.hour" />',
			minuteText : '<bean:message key="timepicker.js.minute" />',
			secondText : '<bean:message key="timepicker.js.second" />',
			millisecText : '<bean:message key="timepicker.js.millisec" />',
			timezoneText : '<bean:message key="timepicker.js.timezone" />',
			currentText : '<bean:message key="timepicker.js.now" />',
			closeText : '<bean:message key="esignage.contentserver.jsp.dialog.button.close" />',
			timeFormat : 'hh:mm:ss',
			amNames : [ 'AM', 'A' ],
			pmNames : [ 'PM', 'P' ],
			ampm : false,
			showSecond : true
		};
		$.timepicker.setDefaults($.timepicker.regional['default']);
	})(jQuery);

	jQuery(window).unbind("beforeunload").bind("beforeunload", function() {
		if (window.realDologout) {
			window.realDologout = false;
			return;
		}
		return ' ';
	});
		
</script>
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/common/prototype/prototype.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/dt.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/http/Request.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/http/Cookie.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/util/Attribute.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/util/Map.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/utils/map.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/Constants.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeFunction.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeAction.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeOnError.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeCheckBox.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeIcon.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/NodeStyle.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeAspect.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeNode.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeNodeHTML.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeContext.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeView.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeAPI.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeUtil.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dt/widget/tree/TreeEvent.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->
<!--script type="text/javascript"
	src="<%=request.getContextPath()%>/modules/framework/js/task_type_define.js?ver=<%=VersionCheckUtils.getDBBuildNum()%>"></script-->