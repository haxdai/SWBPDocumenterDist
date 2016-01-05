<%-- 
    Document   : testView
    Created on : 16/12/2014, 05:09:02 PM
    Author     : carlos.alvarez
--%>

<%@page import="org.semanticwb.SWBUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.semanticwb.SWBPortal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="/swbadmin/css/bootstrap/bootstrap.css" rel="stylesheet"/>
<link href="/swbadmin/css/fontawesome/font-awesome.css" rel="stylesheet"/>
<%--link href="/work/models/documenter/css/swbp.css" rel="stylesheet"/--%>
<script src="/swbadmin/js/jquery/jquery.js"></script>
<script src="/swbadmin/js/bootstrap/bootstrap.js"></script>
<%
    //String filedoc = SWBPortal.getWorkPath() + "/models/documenter/Resource/Alta_Cliente/" + request.getParameter("d") + "/Alta_Cliente.xml";
    String filedoc = SWBPortal.getWorkPath() + "/models/documenter/Resource/Solicitud_de_Vacaciones/" + request.getParameter("d") + "/Solicitud_de_Vacaciones.xml";
    File file = new File(filedoc);
    FileInputStream in = new FileInputStream(file);
    //out.print(SWBUtils.IO.readInputStream(in, "UTF-8"));

    String tlpPath = "/work/models/documenter/jsp/documentation/documentation.xsl";
    javax.xml.transform.Templates tpl = SWBUtils.XML.loadTemplateXSLT(new FileInputStream(SWBUtils.getApplicationPath() + tlpPath));
    out.print(SWBUtils.XML.transformDom(tpl, SWBUtils.XML.xmlToDom(in)));

%>
