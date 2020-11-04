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

<template:addResources type="css" resources="jquery.fancybox.min.css"/>
<template:addResources type="css" resources="imageGallery.css"/>
<template:addResources type="javascript" resources="jquery.fancybox.min.js"/>
<template:addResources type="javascript" resources="imageGallery.js"/>

<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="images" var="images"/>

<c:set var="galleryType" value="${currentNode.properties.imgGalleryType.string}"/>
<!-- Page Content -->
<div class="container page-top">
    <p>
    <h2 class="text-primary text-center mb-5">${bannerText}</h2></p>

    <div class="row">
        <c:choose>
            <c:when test="${galleryType eq 'imgDirectory'}">
                <c:set var="targetFolderPath" value="${currentNode.properties.folder.node.path}"/>
                <jcr:node var="targetNode" path="${targetFolderPath}"/>

                <c:forEach items="${targetNode.nodes}" var="subchild">

                  <c:if test="${jcr:isNodeType(subchild, 'jmix:image')}">
                        <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                            <a href="${subchild.url}" class="fancybox" rel="ligthbox">
                                <img src="${subchild.url}" class="zoom img-fluid " alt="${subchild.name}">
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:when test="${galleryType eq 'imgFile'}">
                <jcr:nodeProperty node="${currentNode}" name="imagesList" var="images"/>
                <c:forEach items="${images}" var="image" varStatus="status">
                    <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                        <a href="${image.node.url}" class="fancybox" rel="ligthbox">
                            <img src="${image.node.url}" class="zoom img-fluid " alt="${image.node.name}">
                        </a>
                    </div>
                </c:forEach>
            </c:when>
        </c:choose>
    </div>
</div>
