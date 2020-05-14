<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/TR/REC-html40"
version="2.0">

  <xsl:output method="html"/>

  <!-- Root template -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="/root/display_name" />
        </title>
        <link rel="stylesheet" type="text/css" href="../css/bpdoc.css" />
      </head>
      <body>
        <xsl:apply-templates select="/root" />

      </body>
    </html>
  </xsl:template>

  <xsl:template match="/root">
    <a class="navbar_style">
      <xsl:attribute name="href">../index.html</xsl:attribute>
      <xsl:value-of select="docs_name" />
    </a>
    <a class="navbar_style">&gt;</a>
    <a class="navbar_style">
      <xsl:value-of select="display_name" />
    </a>


    <div class="hero">
      <div class="info">
        <div id="pageTitle">
          <h1 id="H1TitleId">
            <xsl:value-of select="display_name" />
          </h1>
        </div>
        <h2>
          <xsl:value-of select="description" />
        </h2>
      </div>
    </div>

    <div id="maincol" style="width: calc(100% - 60px); padding-bottom: 100px;">

      <xsl:apply-templates select="content" />
    </div>

  </xsl:template>

  <!--Here are all the functions/variables/ whatever enumerated-->
  <xsl:template match="content">
    <div class="heading expanded" onclick="SectionOnClick(this, 'variables');">
      <p>Content</p>
    </div>
    <div id="variables">
      <div class="member-list">
        <table cellspacing="0">
          <tbody>
            <tr class="header-row">
              <th class="icon-cell" style="width:8%"></th>
              <th class="type-cell" style="width:10%"></th>
              <th class="name-cell" style="width:15%">Name</th>
              <th class="desc-cell">Description</th>
            </tr>
            <xsl:for-each select="node">

              <tr class="normal-row">


                <td class="icon-cell" align="right">

                </td>
                
                <td class="name-cell" align="right">

                </td>
                
                <td class="name-cell">
                  <xsl:value-of select="name"/>
                </td>
                
                <td class="desc-cell">
                  <xsl:value-of select="description"/>
                </td>
              </tr>

            </xsl:for-each>
          </tbody>
        </table>

      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>
