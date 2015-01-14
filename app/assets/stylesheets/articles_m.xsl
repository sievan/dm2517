<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <h1>Nyheter</h1>
    <div class="mobile">
      <xsl:for-each select="articles/article">
        <div class="article">
          <div><h4><xsl:value-of select="title"/></h4></div>
          <div><xsl:value-of select="content"/></div>
        </div>
      </xsl:for-each>
    </div>
</xsl:template>

</xsl:stylesheet>