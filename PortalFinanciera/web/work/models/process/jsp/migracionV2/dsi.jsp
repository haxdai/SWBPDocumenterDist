<%-- 
    Document   : dsi
    Created on : 5/02/2015, 06:01:58 PM
    Author     : carlos.alvarez
--%>

<%@page import="org.semanticwb.process.documentation.model.SectionElement"%>
<%@page import="org.semanticwb.model.SWBComparator"%>
<%@page import="org.semanticwb.process.documentation.model.Instantiable"%>
<%@page import="org.semanticwb.platform.SemanticClass"%>
<%@page import="org.semanticwb.SWBPlatform"%>
<%@page import="org.semanticwb.process.documentation.model.DocumentationInstance"%>
<%@page import="org.semanticwb.model.GenericObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.semanticwb.process.documentation.model.DocumentSectionInstance"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h2>Migración de versión SWBPDocumenter</h2>
<%
    String [] modelIds = request.getParameterValues("mid");
    if (null == modelIds || modelIds.length == 0) {
        %>
        <h3>Seleccione los sitios que desea migrar</h3>
        <form action="#" method="post">
            <fieldset>
            <%
            Iterator <WebSite> sites = WebSite.ClassMgr.listWebSites();
            if (sites.hasNext()) {
                while(sites.hasNext()) {
                    WebSite site =sites.next();
                    String id = site.getId();
                    if ("SWBAdmin".equals(id) || "SWBGlobal".equals(id)) {
                        continue;
                    }
                    %>
                    <input type="checkbox" name="mid" value="<%= id %>"/><%=site.getTitle()%><br>
                    <%
                }
            }
            %>
            </fieldset>
            <button type="submit">Iniciar</button>
        </form>
        <%
    } else {
        %>
        <script>
            function addLogLine(text) {
                var container = document.getElementById("progressMessages");
                if (container) {
                    var msg = document.createTextNode(text);
                    container.appendChild(msg);
                    container.appendChild(document.createElement("br"));
                }
            }
        </script>
        Progreso
        <hr>
        <div id="progressMessages"></div>
        <%
        for (int i = 0; i < modelIds.length; i++) {
            WebSite model = WebSite.ClassMgr.getWebSite(modelIds[i]);
            if (model != null) {
                %>
                <script>
                    addLogLine("Migrando sitio <%= model.getTitle() %>...");
                </script>
                <%
                Iterator<DocumentSectionInstance> itdsi = DocumentSectionInstance.ClassMgr.listDocumentSectionInstances(model);
                %>  
                <script>
                    addLogLine("Migrando instancias de documentación...");
                </script>
                <%
                while (itdsi.hasNext()) {
                    DocumentSectionInstance dsi = itdsi.next();
                    Iterator<GenericObject> itgo = dsi.listRelatedObjects();
                    while (itgo.hasNext()) {
                        GenericObject go = itgo.next();
                        if (go.getSemanticObject().getSemanticClass().equals(DocumentationInstance.sclass)) {
                            DocumentationInstance di = (DocumentationInstance) SWBPlatform.getSemanticMgr().getOntology().getGenericObject(go.getURI());
                            if (!di.hasDocumentSectionInstance(dsi)) {
                                di.addDocumentSectionInstance(dsi);
                            }
                            dsi.setDocumentationInstance(di);
                            if(dsi.getSecTypeDefinition() != null && dsi.getSecTypeDefinition().getParentTemplate() == null){
                                dsi.getSecTypeDefinition().setParentTemplate(di.getDocTypeDefinition());
                            }
                        }
                    }
                    SemanticClass cls = dsi.getSecTypeDefinition() != null && dsi.getSecTypeDefinition().getSectionType() != null ? dsi.getSecTypeDefinition().getSectionType().transformToSemanticClass() : null;
                    if (cls != null && cls.isSubClass(Instantiable.swpdoc_Instantiable, false)) {
                        //out.print("<br><br>dsi Instantiable : " + dsi);
                        //out.print("<br>dsi : " + dsi.getCreated());
                        Iterator<SectionElement> itse = SWBComparator.sortSortableObject(dsi.listDocuSectionElementInstances());
                        while (itse.hasNext()) {
                            SectionElement se = itse.next();
                            //out.print("<br>se : " + se);
                            //out.print("<br>se getDocumentTemplate : " + se.getDocumentTemplate());
                            //out.print("<br>se getDocumentSectionInst : " + se.getDocumentSectionInst());
                            if (se.getDocumentTemplate() == null && dsi != null && dsi.getDocumentationInstance() != null && dsi.getDocumentationInstance().getDocTypeDefinition() != null) {
                                //out.println("<br>asignar dt : " + dsi.getDocumentationInstance().getDocTypeDefinition());
                                se.setDocumentTemplate(dsi.getDocumentationInstance().getDocTypeDefinition());
                            }
                            if(se.getDocumentSectionInst() == null){
                                se.setDocumentSectionInst(dsi);
                            }
                        }
                    }
                }
            }
        }
        %>
        <script>
            addLogLine("Migración terminada");
        </script>
        <%
    }
%>
