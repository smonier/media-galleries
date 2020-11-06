<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>

<template:addResources type="css" resources="videoHeading.css"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="caption" value="${currentNode.properties['caption'].string}"/>
<c:set var="videoNode" value="${currentNode.properties.video.node}"/>
<c:url var="videoURL" value="${videoNode.url}"/>
<template:include view="hidden.generateLink"/>


<div class="video-background-holder">
    <div class="video-background-overlay"></div>
    <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
        <source src="${videoURL}" type="video/mp4">
    </video>
    <div class="video-background-content container h-100">
        <div class="d-flex h-100 text-center align-items-center">
            <div class="w-100 text-white">
                <h1 class="display-4">${title}</h1>
                <p class="lead mb-0">${caption}</p>
                <c:if test="${not empty moduleMap.linkUrl}">
                    <a href="${moduleMap.linkUrl}" class="video__link" target="${moduleMap.linkTarget}">
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>