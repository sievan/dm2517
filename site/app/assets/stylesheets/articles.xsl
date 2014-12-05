<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <h1>Nyheter</h1>
    <xsl:for-each select="articles/article">
      <div>
        <div><h3><xsl:value-of select="title"/></h3></div>
        <div><xsl:value-of select="content"/></div>
      </div>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>