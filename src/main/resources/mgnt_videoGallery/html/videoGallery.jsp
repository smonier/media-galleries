<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="videoButton.css"/>


<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="bannerText" value="${currentNode.properties['bannerText'].string}"/>
<%--<c:set var="itemWidth" value="${currentNode.properties['itemWidth'].string}"/>--%>

<%-- get the child galleryImgs --%>
<c:set var="videos" value="${jcr:getChildrenOfType(currentNode, 'mgnt:externalVideo,mgnt:internalVideo')}"/>

<!--Card-->
<div class="card text-center">


<!--Card content-->
<div class="card-body">
<!--Title-->
<h1 class="card-title text-primary">${title}</h1>
<!--Text-->
<p class="card-text text-secondary">${bannerText}</p>


<!-- Grid row -->
<div class="row">


    <c:forEach items="${videos}" var="video" varStatus="item">
      <div class="col-lg-4 col-md-12 mb-3">

            <template:module node="${video}"  editable="true"/>
      </div>
    </c:forEach>


</div>
<!-- Grid row -->

</div>
</div>
<!--/.Card-->

<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*" />
</c:if>