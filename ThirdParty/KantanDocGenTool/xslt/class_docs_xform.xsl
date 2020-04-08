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
            <!--ICON CELL Saveable-->
          </h1>
        </div>
        <h2>
          <xsl:value-of select="short_tooltip" />
        </h2>
      </div>
    </div>

    <div id="maincol" style="width: calc(100% - 60px); padding-bottom: 100px;">


      <xsl:if test="savegame='ready'">
        <img src="../img/saveable_ready.png" alt="Saveable Ready" title="Saveable Ready"/>
      </xsl:if>
      <xsl:if test="savegame='todo'">
        <img src="../img/saveable_todo.png" alt="Saveable Todo" title="Saveable Todo"/>
      </xsl:if>
      <xsl:if test="savegame='none'">
        <img src="../img/saveable_none.png" alt="Saveable Not needed" title="Saveable Not needed"/>
      </xsl:if>


      <!--ICON CELL Refactor-->

      <xsl:if test="refactor='ready'">
        <img src="../img/refactor_ready.png" alt="Public Variable" title="Refactor Ready"/>
      </xsl:if>
      <xsl:if test="refactor='todo'">
        <img src="../img/refactor_todo.png" alt="Protected Variable" title="Refactor Todo"/>
      </xsl:if>
      <xsl:if test="refactor='none'">
        <img src="../img/refactor_none.png" alt="Private Variable" title="Refactor Not Needed"/>
      </xsl:if>

      <div class="heading expanded" onclick="sectionOnClick(this, 'references');">
        <p>References</p>
      </div>

      <div id="references">
        <div class="member-list">
          <table cellspacing="0">
            <tbody>
              <tr class="normal-row">
                <td class="name-cell">
                  <p>Location</p>
                </td>
                <td class="desc-cell">
                  <p>
                    <xsl:value-of select="path"/>
                  </p>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

      </div>


      <div class="heading expanded" onclick="sectionOnClick(this, 'hierarchy');">
        <p>Inheritance Hierarchy</p>

      </div>

      <div id="hierarchy">
        <xsl:apply-templates select="hierarchy" />
      </div>

      <div class="heading expanded" onclick="sectionOnClick(this, 'description');">
        <p>Remarks</p>
      </div>

      <div id="description" style="">
        <p>
          <xsl:value-of select="description"/>
        </p>
      </div>

      <xsl:apply-templates select="FunctionList" />
    </div>

  </xsl:template>

  <xsl:template match="hierarchy">
    <xsl:apply-templates select="parent" />
  </xsl:template>


  <xsl:template match ="parent[parent]">
    <xsl:apply-templates select="parent" />
    <a style="font-size: 13px">
      <xsl:attribute name="href">
        ../<xsl:value-of select="id" />/<xsl:value-of select="id" />.html
      </xsl:attribute>
      <xsl:value-of select="id" />
    </a>
    <br></br>
  </xsl:template>

  <xsl:template match ="parent[not(parent)]">
    <p style="font-size: 11px;">
      <xsl:apply-templates select="parent" />
    </p>
    <xsl:value-of select="id"/>
    <br></br>
  </xsl:template>

  <!--Here are all the functions/variables/ whatever enumerated-->
  <xsl:template match="FunctionList">
    <div class="heading expanded" onclick="SectionOnClick(this, 'variables');">
      <p>Variables</p>
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
            <xsl:for-each select="Function">
              <xsl:if test="node_type='Variable'">
                <!--<xsl:apply-templates select="Function">-->

                <tr class="normal-row">
                  <td class="icon-cell">
                    <xsl:if test="access_spec='Public'">
                      <img src="../img/api_variable_public.png" alt="Public Variable" title="Public Variable"/>
                    </xsl:if>
                    <xsl:if test="access_spec='Protected'">
                      <img src="../img/api_variable_protected.png" alt="Protected Variable" title="Protected Variable"/>
                    </xsl:if>
                    <xsl:if test="access_spec='Private'">
                      <img src="../img/api_variable_private.png" alt="Private Variable" title="Private Variable"/>
                    </xsl:if>

                    <xsl:if test="static='True'">
                      <img src="../img/api_function_static.png" alt="Static" title="Static"/>
                    </xsl:if>

                    <xsl:if test="const='True'">
                      <img src="../img/api_function_const.png" alt="Const" title="Const"/>
                    </xsl:if>

                    <xsl:if test="edit_type='ReadWrite'">
                      <img src="../img/blueprint_readwrite.png" alt="Blueprint Read Write Access" title="Blueprint Read Write Access"/>
                    </xsl:if>
                    <xsl:if test="edit_type='ReadOnly'">
                      <img src="../img/blueprint_readonly.png" alt="Blueprint Read Only Access" title="Blueprint Read Only Access"/>
                    </xsl:if>
                    <xsl:if test="edit_type='None'">
                      <img src="../img/blueprint_none.png" alt="No Blueprint Access" title="No Blueprint Access"/>
                    </xsl:if>

                  </td>
                  <td class="name-cell" align="right">
                    <span class="type-span">
                      <p>
                        <xsl:value-of select="outputs/param/type"/>
                      </p>
                    </span>
                  </td>
                  <td class="name-cell">
                    <p>
                      <xsl:value-of select="shorttitle"/>
                    </p>
                  </td>
                  <td class="desc-cell">
                    <xsl:value-of select="description"/>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </tbody>
        </table>

      </div>
    </div>


    <div class="heading expanded" onclick="sectionOnClick(this, 'functions_0');">
      <p>Functions</p>
    </div>

    <div id="functions_0">
      <div class="member-list">
        <table cellspacing="0">
          <tbody>
            <tr class="header-row">
              <th class="icon-cell" style="width:8%"></th>
              <th class="type-cell" style="width:10%"></th>
              <th class="name-cell" style="width:15%">Name</th>
              <th class="desc-cell">Description</th>
            </tr>
            <xsl:for-each select="Function">
              <xsl:if test="node_type='Function'">

                <!--ICON HERE-->
                <tr class="normal-row">
                  <td class="icon-cell">
                    <xsl:if test="access_spec='Public'">
                      <img src="../img/api_function_public.png" alt="Public Function" title="Public Function"/>
                    </xsl:if>
                    <xsl:if test="access_spec='Protected'">
                      <img src="../img/api_function_protected.png" alt="Protected Function" title="Protected Function"/>
                    </xsl:if>
                    <xsl:if test="access_spec='Private'">
                      <img src="../img/api_function_private.png" alt="Private Function" title="Private Function"/>
                    </xsl:if>


                    <xsl:if test="static='True'">
                      <img src="../img/api_function_static.png" alt="Static" title="Static"/>
                    </xsl:if>

                    <xsl:if test="const='True'">
                      <img src="../img/api_function_const.png" alt="Const" title="Const"/>
                    </xsl:if>


                  </td>
                  <!-- RETURN TYPE HERE-->
                  <td class="name-cell" align="right">
                    <span class="type-span">
                      <p>
                        <xsl:choose>
                          <xsl:when test="outputs/param/type='Exec'">
                            Void
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:for-each select="outputs/param">
                              <xsl:value-of select="type"/>
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="translate(name,' ','')"/>
                              <br></br>
                            </xsl:for-each>

                          </xsl:otherwise>
                        </xsl:choose>
                      </p>
                    </span>
                  </td>

                  <!--NAME HERE-->
                  <td class="name-cell">
                    <p>
                      <xsl:value-of select="translate(shorttitle,' ','')"/>
                      <div class="name-cell-arguments">
                        (
                        <br></br>
                        <xsl:for-each select="inputs/param">
                          <xsl:choose>
                            <xsl:when test="type='Exec'">

                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="replace(replace(type,'ObjectReference','&#38;'),'(\()byref(\))','&#38;')"/>
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="replace(name,' ','')"/>
                              <br></br>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:for-each>
                        )
                      </div>
                    </p>
                  </td>

                  <!--DESC HERE-->
                  <td class="desc-call">
                    <p>
                      <xsl:value-of select="description"/>
                    </p>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>
