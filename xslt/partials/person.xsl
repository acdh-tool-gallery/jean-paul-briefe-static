<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:person" name="person_detail">
        <div class="row pt-3">
            <div class="col-md-6">
                <h2 class="fs-4 text-center p-2">Info</h2>
                <p class="lead">
                    <xsl:apply-templates select=".//tei:note"></xsl:apply-templates>
                </p>
                <dl>
                    <dt>Vorname</dt>
                    <dd><xsl:value-of select=".//tei:forename"/></dd>
                    <dt>Nachname</dt>
                    <dd><xsl:value-of select=".//tei:surname"/></dd>
                    <dt>geboren</dt>
                    <dd><xsl:value-of select=".//tei:birth"/></dd>
                    <dt>gestorben</dt>
                    <dd><xsl:value-of select=".//tei:death"/></dd>
                    <dt>GND</dt>
                    <dd>
                        <xsl:if test="./tei:idno">
                            <a href="{./tei:idno/text()}"><xsl:value-of select="./tei:idno"/></a>
                        </xsl:if>
                    </dd>
                </dl>
            </div>
            <div class="col-md-6">
                <h2 class="fs-4 text-center p-2">Erwähnungen im Brieftext</h2>
                <ul>
                    <xsl:for-each select=".//tei:linkGrp[@n]/tei:ptr[@type='letter' and @target]">
                        <xsl:variable name="band">
                            <xsl:value-of select="ancestor-or-self::tei:linkGrp[@n][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="briefNr">
                            <xsl:value-of select="tokenize(@target, '-')[1]"/>
                        </xsl:variable>
                        <xsl:variable name="letterUrl">
                            <xsl:value-of select="concat($band, '_', $briefNr, '.html')"/>
                        </xsl:variable>
                        <li><a href="{$letterUrl}"><xsl:value-of select="$letterUrl"/></a></li>
                    </xsl:for-each>
                </ul>
            </div>
        </div>
        
        
        
    </xsl:template>
</xsl:stylesheet>