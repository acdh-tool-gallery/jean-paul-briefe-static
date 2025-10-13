<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar" version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>

    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/blockquote.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="concat(data(tei:TEI/@xml:id), '.xml')"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[@n = 'digital']"/>
    </xsl:variable>
    <xsl:variable name="receiver">
        <xsl:value-of select=".//tei:correspAction[@type = 'received']/tei:persName"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100" lang="{$default_lang}">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <div class="row">
                        <div class="col-md-7">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb"
                                class="ps-5 p-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="index.html">
                                            <xsl:value-of select="$project_short_title"/>
                                        </a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="toc.html">von Briefe</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        <xsl:value-of select="$receiver"/>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col-md-5 text-end">
                            <span class="badge text-bg-secondary fs-6 mt-3">
                                <a class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='correspondence']/tei:ptr[@type='prev']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-left"></i>
                                    <span class="visually-hidden">Zum vorigen Brief in der Korrespondenz</span>
                                </a>
                                Korrespondenz
                                <a class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='correspondence']/tei:ptr[@type='next']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-right"></i>
                                    <span class="visually-hidden">Zum nächsten Brief in der Korrespondenz</span>
                                </a>
                            </span>
                            <span class="badge text-bg-secondary fs-6 mt-3 ms-2">
                                <a href="#" class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='corpus']/tei:ptr[@type='prev']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-left"></i>
                                    <span class="visually-hidden">Zum vorigen Brief im Korpus</span>
                                </a>
                                Korpus
                                <a href="#" class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='corpus']/tei:ptr[@type='next']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-right"></i>
                                    <span class="visually-hidden">Zum nächsten Brief im Korpus</span>
                                </a>
                            </span>
                            <span class="badge text-bg-secondary fs-6 mt-3 ms-2 me-5">
                                <a href="#" class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='edition']/tei:ptr[@type='prev']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-left"></i>
                                    <span class="visually-hidden">Zum vorigen Brief in der Edition</span>
                                </a>
                                Korpus
                                <a href="#" class="text-bg-secondary">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat(.//tei:correspContext[@n='edition']/tei:ptr[@type='next']/@target, '.html')"/>
                                    </xsl:attribute>
                                    <i class="bi bi-chevron-double-right"></i>
                                    <span class="visually-hidden">Zum nächsten Brief in der Edition</span>
                                </a>
                            </span>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start"/>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1 class="fs-2 pt-2">
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2" title="Zum TEI/XML Dokument"
                                            visually-hidden="true">
                                            <span class="visually-hidden">Zum TEI/XML
                                                Dokument</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start"/>
                        </div>
                        <div class="row">
                            <div class="col-md-8 briefansicht">
                                <h2 class="visually-hidden">Brieftext</h2>
                                <xsl:apply-templates select=".//tei:div[@type='letter']"/>
                            </div>
                            <div class="col-md-4 brief-sidebar">
                                <div id="textgrundlage" class="p-2">
                                    <h2 class="fs-6">Textgrundlage</h2>
                                    <xsl:value-of select=".//tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
                                </div>
                                <div id="kommentar" class="p-2">
                                    <h2 class="fs-6">Kommentar (der gedruckten Ausgabe)</h2>
                                    <xsl:apply-templates select=".//tei:div[@type='comment']"/>
                                </div>
                                
                            </div>
                        </div>
                        <div class="text-center p-4">
                            <xsl:call-template name="blockquote">
                                <xsl:with-param name="pageId" select="$link"/>
                            </xsl:call-template>
                        </div>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                
                <xsl:for-each select="//tei:note[@corresp]">
                    <xsl:variable name="modalId">
                        <xsl:value-of select="replace(./@corresp, '#', '')"/>
                    </xsl:variable>
                    <div class="modal fade" id="{$modalId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Info zu Zeile <xsl:value-of select="$modalId"/></h1>
                                </div>
                                <div class="modal-body">
                                    <ul>
                                        <xsl:for-each select=".//tei:person">
                                            <li>
                                                <a href="{replace(./@corresp, '#', '')||'.html'}">
                                                    <xsl:value-of select="string-join(./tei:persName[1]//text())"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                    <ul>
                                        <xsl:for-each select=".//tei:place">
                                            <li>
                                                <a href="{replace(./@corresp, '#', '')||'.html'}">
                                                    <xsl:value-of select="string-join(./tei:placeName[1]//text())"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Schließen</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//tei:note[@corresp]">
        <xsl:variable name="modalId">
            <xsl:value-of select="@corresp"/>
        </xsl:variable>
        <button type="button" class="entity btn btn-primary" data-bs-toggle="modal" data-bs-target="{$modalId}">
            <i class="bi bi-box-arrow-in-up-right"></i>
            <span class="visually-hidden">Infos zu erwähnten Personen oder Orten</span>
        </button>
    </xsl:template>
    
</xsl:stylesheet>
