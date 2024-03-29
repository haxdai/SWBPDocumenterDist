<%-- 
    Document   : modelerView
    Created on : 7/05/2013, 12:09:42 PM
    Author     : Hasdai Pacheco <ebenezer.sanchez@infotec.com.mx>
--%>
<%@page import="org.semanticwb.process.documentation.resources.SWPUserDocumentationResource"%>
<%@page import="org.semanticwb.SWBUtils"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.semanticwb.SWBPortal"%>
<%@page import="org.semanticwb.model.SWBComparator"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.semanticwb.portal.api.SWBResourceURL"%>
<%@page import="org.semanticwb.model.Role"%>
<%@page import="org.semanticwb.process.documentation.model.DocumentationInstance"%>
<%@page import="org.semanticwb.process.documentation.model.Documentation"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page import="org.semanticwb.model.User"%>
<%@page import="org.semanticwb.process.model.Process"%>
<%@page import="org.semanticwb.portal.api.SWBParamRequest"%>
<%
    SWBParamRequest paramRequest = (SWBParamRequest) request.getAttribute("paramRequest");
    User user = paramRequest.getUser();
    WebSite site = paramRequest.getWebPage().getWebSite();
    String idp = request.getParameter("idp");
    Process process = Process.ClassMgr.getProcess(idp, site);
    String version = request.getParameter("version") != null ? request.getParameter("version") : "";
    Documentation actualVersion = null;
    DocumentationInstance di = null;
    
    if (null != process) {
        actualVersion = Documentation.getActualDocumentationVersion(process);
        if (null != actualVersion && !version.isEmpty()) {
            actualVersion = Documentation.ClassMgr.getDocumentation(version, site);
            idp = actualVersion.getProcess().getId();
        }
        di = null != actualVersion ? actualVersion.getDocumentationInstance() : null;
    }

    Role docRole = site.getUserRepository().getRole(paramRequest.getResourceBase().getAttribute("docRole"));//TODO: Hacer cnfigurable el rol
    Role adminRole = site.getUserRepository().getRole("admin");//TODO: Hacer cnfigurable el rol
    boolean isDocumenter = user.hasRole(docRole) || user.hasRole(adminRole);
    
    String idpg = request.getParameter(SWPUserDocumentationResource.PARAM_PROCESSGROUP);
    if (null == idpg) idpg = "";
    
    if (null == di) {
        String msg = null == process ? paramRequest.getLocaleString("msgModelError") : paramRequest.getLocaleString("lblNoDocumentation");
        %>
        <div class="row text-right">
            <ul class="list-unstyled list-inline ">
                <li>
                    <a href="<%=paramRequest.getRenderUrl().setMode(SWBResourceURL.Mode_VIEW).setParameter(SWPUserDocumentationResource.PARAM_PROCESSGROUP, idpg)%>" class="btn btn-default swbp-btn-action" title="<%=paramRequest.getLocaleString("lblBack")%>">
                        <span class="fa fa-reply"></span><%=paramRequest.getLocaleString("lblBack")%>
                    </a>
                </li>
            </ul>
        </div>
        <div class="alert alert-block alert-warning fade in">
            <%= msg %>
        </div>
        <%
    } else {
        %>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default swbp-panel">
                    <div class="panel-heading swbp-panel-title">
                        <div class="panel-title">
                            <div class="row">
                                <div class="col-lg-4">
                                    <h1 class="panel-title"><strong><%=process.getTitle()%></strong></h1>
                                </div>
                                <%
                                if (isDocumenter) {
                                    %>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <form id="collapseOne" class="form-horizontal panel-collapse collapse" role="form">
                                            <input type="hidden" id="version" name="version">
                                            <input type="hidden" name="idp" value="<%= idp %>">
                                            <select class="form-control" onchange="document.getElementById('version').value = value;submit();">
                                            <%
                                            Iterator<Documentation> itdoc = SWBComparator.sortByCreated(Documentation.ClassMgr.listDocumentationByProcess(process), true);
                                            while (itdoc.hasNext()) {
                                                Documentation documentation = itdoc.next();
                                                String title = documentation.getTitle();
                                                %>
                                                <option value="<%=documentation.getId()%>" <%if (documentation.equals(actualVersion)) {%>selected<%}%>><%=title%></option>
                                                <%
                                            }
                                            %>
                                            </select>
                                        </form>
                                        <strong id="lblTitle"><%=actualVersion != null ? (actualVersion.getTitle() != null ? actualVersion.getTitle() : "") : ""%></strong>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <a id="collapseVersionButton" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="btn btn-success pull-right">
                                            <span class="fa fa-sort-numeric-desc"></span><%=paramRequest.getLocaleString("lblShowVersion")%>
                                        </a>
                                    </div>
                                    <%
                                }
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                    String filedoc = SWBPortal.getWorkPath() + "/models/" + paramRequest.getWebPage().getWebSiteId() + "/Resource/" + process.getId() + "/";
                    filedoc += actualVersion.getId() + "/" + process.getId() + ".html";
                    File file = new File(filedoc);
                    FileInputStream in = new FileInputStream(file);
                    out.print(SWBUtils.IO.readInputStream(in,"UTF-8"));
                    %>
                </div>
            </div>
        </div>
        <%
    }
%>
<script type="text/javascript">
    var winVar;
    $(document).ready(function() {
        var draggingSVG=false, x0SVG, y0SVG;
        var urllocation = window.location + '';
        
        $("svg").mousedown(function(event) {
            draggingSVG = true;
            x0SVG = event.pageX;
            y0SVG = event.pageY;
            $(this).attr('style', 'cursor:move;');
        });
        
        $("svg").mousemove(function(event) {
            if (draggingSVG) {
                var viewBox = document.getElementById("modeler").getAttribute('viewBox');
                var viewBoxValues = viewBox.split(' ');
                viewBoxValues[0] -= event.pageX - x0SVG;
                viewBoxValues[1] -= event.pageY - y0SVG;
                document.getElementById("modeler").setAttribute('viewBox', viewBoxValues.join(' '));
                x0SVG = event.pageX;
                y0SVG = event.pageY;
            }
        });
        
        $("svg").mouseup(function() {
            draggingSVG = false;
            $(this).attr('style', 'cursor:default;');
        });
        
        $("svg").mouseout(function() {
            draggingSVG = false;
        });
        
        urllocation = (urllocation.lastIndexOf('#') > 0) ? urllocation.substring((urllocation.lastIndexOf('#') + 1), urllocation.length) : null;
        
        if (urllocation) {
            $('#myTab0 a[href=#' + urllocation + ']').tab('show');
        }

        $("#collapseModelButton").on("click", function() {
            if (!($(this).data('data-state')) || $(this).data('data-state') === "off") {
                $(this).button('toggle');
                $(this).data('data-state', 'on');
                $(this).text('Modelo');
                $(this).removeClass('collapseModelButtonSelected');
            } else {
                $(this).addClass('collapseModelButtonSelected');
                $(this).button('toggle');
                $(this).text('Modelo');
                $(this).data('data-state', 'off');
            }
        });
        <% if (isDocumenter) {
            %>
            $("#collapseVersionButton").on("click", function() {
                var lblTitle = $('#lblTitle');
                if (!($(this).data('data-state')) || $(this).data('data-state') === "off") {
                    $(this).button('toggle');
                    $(this).data('data-state', 'on');
                    $(this).text('<%=paramRequest.getLocaleString("lblHideVersion")%>');
                    lblTitle.html('');
                } else {
                    $(this).button('toggle');
                    $(this).text('<%=paramRequest.getLocaleString("lblShowVersion")%>');
                    $(this).data('data-state', 'off');
                    lblTitle.html('<%=actualVersion != null ? (actualVersion.getTitle() != null ? actualVersion.getTitle() : "") : ""%>');
                }
            });
            <%
        }%>
        
        $("rect[class='task']").on("click", function() {
            //console.log($(this));
            //console.log($(this).attr('id'));
            var task = $(this), taskSelected = $('#taskSelected'), tab = $('#Activity');
            var colors = task.attr('style') ? task.attr('style').split(' ') : ' ';
            var idto = task.attr('id');
            idto = idto.substring((idto.lastIndexOf(":") + 1), idto.length);
            var liactivity = $('#liactivity' + idto);
            var ulchilds = $('#ulactivity').children('li');
            
            task.removeAttr('style');
            task.attr('style', colors[0] + '; ' + 'stroke:#00cc00;');
            if (taskSelected.attr('value') && taskSelected.attr('value') !== task.attr('id')) {
                var taskSelectedOld = $(document.getElementById(taskSelected.attr('value')));
                taskSelectedOld.attr('style', taskSelectedOld.attr('style')+';' + 'stroke:#79ADC8;');
            }
            taskSelected.attr('value', task.attr('id'));
            $('#myTab0 a[href="' + tab.attr('href') + '"]').tab('show');
            
            removeClassAct(liactivity);
            
            ulchilds.each(function() {
                var li = $(this);
                if (liactivity.attr('id') !== li.attr('id')) {
                    li.removeClass('liselectedUDV');
                } else {
                    li.addClass('liselectedUDV');
                }
            });
            $('html,body').animate({scrollTop: $("#liactivity" + idto).offset().top - 100}, 1000);
        });
        
        var viewBox = document.getElementById("modeler").getAttribute('viewBox');
        var element = document.getElementById("viewBox");
        element.value = viewBox;
    });
       
    function removeClassAct(liactivity) {
        window.clearTimeout(winVar);
        winVar = window.setTimeout(function() {
            liactivity.removeClass('liselectedUDV');
        }, 3000);
    }

    function submit_download_form(output_format) {
        var form = document.getElementById("svgform");
        if (output_format === "svg" || output_format === "png") {
            var svg = document.getElementsByTagName("svg")[0];
            var svg_xml = (new XMLSerializer).serializeToString(svg);
            form['data'].value = svg_xml;
        }
        form['output_format'].value = output_format;
        form.submit();
    }
</script>
<%
    SWBResourceURL exportUrl = paramRequest.getRenderUrl().setCallMethod(SWBResourceURL.Call_DIRECT);
    exportUrl.setMode(SWPUserDocumentationResource.MODE_EXPORT_MODEL);
%>
<form id="svgform" accept-charset="utf-8" method="post" action="<%= exportUrl%>">
    <input type="hidden" id="output_format" name="output_format" value="">
    <input type="hidden" name="idp" value="<%= idp%>">
    <input type="hidden" id="data" name="data" value="">
    <input type="hidden" id="viewBox" name="viewBox" value="">
    <input type="hidden" id="taskSelected" name="taskSelected">
</form>