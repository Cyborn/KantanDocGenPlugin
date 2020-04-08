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
        <link rel="stylesheet" type="text/css" href="./css/bpdoc.css" />
      </head>
      <body>

        <xsl:apply-templates />



      </body>
    </html>
  </xsl:template>
  <!-- Templates to match specific elements in the input xml -->
  <xsl:template match="/root">

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
          API documentation of Hubris the Game
        </h2>
      </div>
    </div>


    <div id="maincol" style="width: calc(100% - 60px);">
      <div class="heading expanded" onclick="sectionOnClick(this, 'hierarchy');">
        <p>Native Classes</p>
      </div>


      <xsl:apply-templates select="classes" />

      <!-- todo select bluepritn classes-->
      <!--<xsl:apply-templates select="classes" />-->
    </div>

  </xsl:template>



  <xsl:template match="classes">

    <table cellspacing="0">
      <tbody>
        <tr class="header-row">
          <th class="icon-cell" style="width:4%"></th>
          <th class="icon-cell" style="width:4%"></th>
          <th class="name-cell" style="width:15%">Name</th>
          <th class="desc-cell">Description</th>
        </tr>
        
        
        <xsl:apply-templates select="class[(native='True')]">
          <xsl:sort select="substring(display_name,string-length(substring-before(display_name, '_'))+1)"/>
        </xsl:apply-templates>

      </tbody>
    </table>

    <div class="heading expanded" onclick="sectionOnClick(this, 'hierarchy');">
      <p>Blueprint Classes</p>
    </div>

    <table cellspacing="0">
      <tbody>
        <tr class="header-row">
          <th class="icon-cell" style="width:4%"></th>
          <th class="icon-cell" style="width:4%"></th>
          <th class="name-cell" style="width:15%">Name</th>
          <th class="desc-cell">Description</th>
        </tr>
        <xsl:apply-templates select="class[(native='False')]">
          <xsl:sort select="substring(display_name,string-length(substring-before(display_name, '_'))+1)"/>
        </xsl:apply-templates>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="class[(native='True')]">
    <tr class="normal-row">

      <!--ICON CELL Saveable-->
      <td class="icon-cell">
        <xsl:if test="savegame='ready'">
          <img src="img/saveable_ready.png" alt="Public Variable" title="Saveable Ready"/>
        </xsl:if>
        <xsl:if test="savegame='todo'">
          <img src="img/saveable_todo.png" alt="Protected Variable" title="Saveable Todo"/>
        </xsl:if>
        <xsl:if test="savegame='none'">
          <img src="img/saveable_none.png" alt="Private Variable" title="Saveable Not needed"/>
        </xsl:if>
      </td>

      <!--ICON CELL Refactor-->
      <td class="icon-cell">
        <xsl:if test="refactor='ready'">
          <img src="img/refactor_ready.png" alt="Public Variable" title="Refactor Ready"/>
        </xsl:if>
        <xsl:if test="refactor='todo'">
          <img src="img/refactor_todo.png" alt="Protected Variable" title="Refactor Todo"/>
        </xsl:if>
        <xsl:if test="refactor='none'">
          <img src="img/refactor_none.png" alt="Private Variable" title="Refactor Not Needed"/>
        </xsl:if>
      </td>

      <td class="name-cell">
        <p>
          <a>
            <xsl:attribute name="href">
              ./<xsl:value-of select="id" />/<xsl:value-of select="id" />.html
            </xsl:attribute>

            <xsl:choose>
              <xsl:when test="contains(display_name,'_')">
                <xsl:value-of select="substring-after(display_name,'_')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="display_name"/>
              </xsl:otherwise>
            </xsl:choose>


          </a>
        </p>
      </td>

      <!--Description CELL -->
      <td class="desc-cell">
        <xsl:value-of select="short_tooltip" />
      </td>

    </tr>
  </xsl:template>


  <xsl:template match="class[(native='False')]">
    <tr class="normal-row">

      <!--ICON CELL Saveable-->
      <td class="icon-cell">
        <xsl:if test="savegame='ready'">
          <img src="img/saveable_ready.png" alt="Public Variable" title="Saveable Ready"/>
        </xsl:if>
        <xsl:if test="savegame='todo'">
          <img src="img/saveable_todo.png" alt="Protected Variable" title="Saveable Todo"/>
        </xsl:if>
        <xsl:if test="savegame='none'">
          <img src="img/saveable_none.png" alt="Private Variable" title="Saveable Not needed"/>
        </xsl:if>
      </td>

      <!--ICON CELL Refactor-->
      <td class="icon-cell">
        <xsl:if test="refactor='ready'">
          <img src="img/refactor_ready.png" alt="Public Variable" title="Refactor Ready"/>
        </xsl:if>
        <xsl:if test="refactor='todo'">
          <img src="img/refactor_todo.png" alt="Protected Variable" title="Refactor Todo"/>
        </xsl:if>
        <xsl:if test="refactor='none'">
          <img src="img/refactor_none.png" alt="Private Variable" title="Refactor Not Needed"/>
        </xsl:if>
      </td>

      <td class="name-cell">
        <p>
          <a>
            <xsl:attribute name="href">
              ./<xsl:value-of select="id" />/<xsl:value-of select="id" />.html
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(display_name,'_')">
                <xsl:value-of select="substring-after(display_name,'_')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="display_name"/>
              </xsl:otherwise>
            </xsl:choose>
          </a>
        </p>
      </td>

      <!--Description CELL -->
      <td class="desc-cell">
        <xsl:value-of select="short_tooltip" />
      </td>

    </tr>
  </xsl:template>

</xsl:stylesheet>
