<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <h1>Nyheter</h1>
    <xsl:for-each select="articles/article">
      <div class="article">
        <div><h3><xsl:value-of select="title"/></h3></div>
        <div class="author"><xsl:value-of select="author"/></div>
        <div><xsl:value-of select="content"/></div>
        <xsl:value-of select="edit" disable-output-escaping="yes"/>
      </div>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>