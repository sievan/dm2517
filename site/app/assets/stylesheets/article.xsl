<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="article">
  <div><h3><xsl:value-of select="title"/></h3></div>
  <div><xsl:value-of select="content"/></div>
</xsl:template>

</xsl:stylesheet>