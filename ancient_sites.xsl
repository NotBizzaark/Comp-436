<?xml version="1.0" encoding="ISO-8859-1"?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
      <html>
        <body>
          <h3>Ancient Sites</h3>
          <table border="1">
            <tr>
              <th>Name</th>
              <th>Year</th>
              <th>Dynasty</th>
              <th>Period (Start-End)</th>
              <th>Links</th>
              <th>images</th>
            </tr>
            <xsl:apply-templates select="ancient_sites/site">
              <xsl:sort select="location" order="ascending" data-type="string"/>
            </xsl:apply-templates>
          </table>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="site">
      <tr>
        <xsl:apply-templates select="name[@language='english']"/>
        <xsl:apply-templates select="history"/>
        <xsl:apply-templates select="links/overview[@type='general']"/>
        <xsl:apply-templates select="images"/>
      </tr>
    </xsl:template>

    <xsl:template match="name[@language='english']">
      <td>
        <xsl:value-of select="."/>
      </td>
    </xsl:template>

    <xsl:template match="history">
      <td>
        <xsl:value-of select="year"/>
        <xsl:text> &#160;</xsl:text>
        <xsl:value-of select="year/@era"/>
      </td>
      <td>
        <xsl:value-of select="./dynasty"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="year[@range='start'] and year[@range='end']">
            <xsl:value-of select="year[@range='start']"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="year[@range='end']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="year[@range='start']"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </xsl:template>

    <xsl:template match="images">
      <td>
        <xsl:value-of select="count(image)"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="image[@type='jpg']"/>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="image[@type='jpg'][position() = last()]"/>
              </xsl:attribute>
              <xsl:value-of select="image[@type='jpg'][position() = last()]"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>No Image</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </xsl:template>
  </xsl:stylesheet>