<cfcomponent displayname="PosMedia DAO" output="false" hint="DAO Component Handles all Database access for the table PosMedia.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PosMediaDAO.cfc
Description: DAO Component Handles all Database access for the table PosMedia.  Requires Coldspring v1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PosMediaBean.getpostxid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PosMediaDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>


<cffunction name="save" access="public" returntype="PosMediaBean" output="false" hint="DAO method">
<cfargument name="PosMediaBean" type="PosMediaBean" required="yes" />
<!-----[  If a SequenceID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PosMediaBean.getSequenceID() neq "0")>	
		<cfset PosMediaBean = update(arguments.PosMediaBean)/>
	<cfelse>
		<cfset PosMediaBean = create(arguments.PosMediaBean)/>
	</cfif>
	<cfreturn PosMediaBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PosMediaBean" type="PosMediaBean" required="true" /> 
	<cfset var qPosMediaBeanDelete = 0 >
<cfquery name="PosMediaBeanDelete" datasource="#variables.dsn#" >
		DELETE FROM PosMedia
		WHERE 
		SequenceID = <cfqueryparam value="#PosMediaBean.getSequenceID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="PosMediaBean" output="false" hint="DAO Method. - Reads a PosMediaBean into the bean">
<cfargument name="argsPosMediaBean" type="PosMediaBean" required="true" />
	<cfset var PosMediaBean  =  arguments.argsPosMediaBean />
	<cfset var QPosMediaselect = "" />
	<cfquery name="QPosMediaselect" datasource="#variables.dsn#">
		SELECT 
		PosTXID, SequenceID, MediaID, Description, AllowChange, RoundTotal, TaxExempt, ReferenceType, ReferenceID, MediaUnit, MediaRound, MediaChange, MediaExt, MediaTax
		FROM PosMedia 
		WHERE 
		SequenceID = <cfqueryparam value="#PosMediaBean.getSequenceID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPosMediaselect.recordCount >
		<cfscript>
		PosMediaBean.setPosTXID(QPosMediaselect.PosTXID);
         PosMediaBean.setSequenceID(QPosMediaselect.SequenceID);
         PosMediaBean.setMediaID(QPosMediaselect.MediaID);
         PosMediaBean.setDescription(QPosMediaselect.Description);
         PosMediaBean.setAllowChange(QPosMediaselect.AllowChange);
         PosMediaBean.setRoundTotal(QPosMediaselect.RoundTotal);
         PosMediaBean.setTaxExempt(QPosMediaselect.TaxExempt);
         PosMediaBean.setReferenceType(QPosMediaselect.ReferenceType);
         PosMediaBean.setReferenceID(QPosMediaselect.ReferenceID);
         PosMediaBean.setMediaUnit(QPosMediaselect.MediaUnit);
         PosMediaBean.setMediaRound(QPosMediaselect.MediaRound);
         PosMediaBean.setMediaChange(QPosMediaselect.MediaChange);
         PosMediaBean.setMediaExt(QPosMediaselect.MediaExt);
         PosMediaBean.setMediaTax(QPosMediaselect.MediaTax);
         
		</cfscript>
	</cfif>
	<cfreturn PosMediaBean />
</cffunction>
		

<cffunction name="GetAllPosMediaBeans" access="public" output="false" returntype="query" hint="Returns a query of all PosMediaBeans in our Database">
<cfset var QgetallPosMediaBeans = 0 />
	<cfquery name="QgetallPosMediaBeans" datasource="#variables.dsn#">
		SELECT PosTXID, SequenceID, MediaID, Description, AllowChange, RoundTotal, TaxExempt, ReferenceType, ReferenceID, MediaUnit, MediaRound, MediaChange, MediaExt, MediaTax
		FROM PosMedia 
		ORDER BY SequenceID
	</cfquery>
	<cfreturn QgetallPosMediaBeans />
</cffunction>

<cffunction name="getSequencesforPosTXID" access="public" output="no" returntype="string" hint="Determines all teh sequence numbers for a specific PosTXID in the PosMedia Table.  This is required for processing transactions where multiple media records are provided.  For example sales with cash and credit card.">
<cfargument name="argsPosMediaBean" type="PosMediaBean" required="true" />
	<cfset var PosMediaBean  =  arguments.argsPosMediaBean />
	<cfset var QPosMediaselect = "" />
         <cfquery name="QPosMediaselect" datasource="#variables.dsn#">
                 SELECT SequenceID from PosMedia 
                 WHERE
                 PosTXID = <cfqueryparam value="#PosMediaBean.getPosTXID()#" cfsqltype="cf_sql_integer" />
         </cfquery>
     <cfreturn valuelist( QPosMediaselect.sequenceID) />
</cffunction>

<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PosMediaBean" output="false" hint="DAO method">
<cfargument name="argsPosMediaBean" type="PosMediaBean" required="yes" displayname="create" />
	<cfset var qPosMediaBeanInsert = 0 />
	<cfset var PosMediaBean = arguments.argsPosMediaBean />
	
	<cfquery name="qPosMediaBeanInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PosMedia
		( PosTXID, MediaID, Description, AllowChange, RoundTotal, TaxExempt, ReferenceType, ReferenceID, MediaUnit, MediaRound, MediaChange, MediaExt, MediaTax ) VALUES

		(

		<cfqueryparam value="#PosMediaBean.getpostxid()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosMediaBean.getmediaid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosMediaBean.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosMediaBean.getallowchange()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosMediaBean.getroundtotal()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosMediaBean.gettaxexempt()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosMediaBean.getreferencetype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosMediaBean.getreferenceid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosMediaBean.getmediaunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMediaBean.getmediaround()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMediaBean.getmediachange()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMediaBean.getmediaext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMediaBean.getmediatax()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SELECT Ident_Current('PosMedia') as SequenceID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PosMediaBean.setSequenceID(qPosMediaBeanInsert.SequenceID)>

	<cfreturn PosMediaBean />
</cffunction>

<cffunction name="update" access="private" returntype="PosMediaBean" output="false" hint="DAO method">
<cfargument name="argsPosMediaBean" type="PosMediaBean" required="yes" />
	<cfset var PosMediaBean = arguments.argsPosMediaBean />
	<cfset var PosMediaBeanUpdate = 0 >
	<cfquery name="PosMediaBeanUpdate" datasource="#variables.dsn#" >
		UPDATE PosMedia SET
postxid  = <cfqueryparam value="#PosMediaBean.getPosTXID()#" cfsqltype="CF_SQL_VARCHAR"/>,
mediaid  = <cfqueryparam value="#PosMediaBean.getMediaID()#" cfsqltype="CF_SQL_INTEGER"/>,
description  = <cfqueryparam value="#PosMediaBean.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
allowchange  = <cfqueryparam value="#PosMediaBean.getAllowChange()#" cfsqltype="CF_SQL_BIT"/>,
roundtotal  = <cfqueryparam value="#PosMediaBean.getRoundTotal()#" cfsqltype="CF_SQL_BIT"/>,
taxexempt  = <cfqueryparam value="#PosMediaBean.getTaxExempt()#" cfsqltype="CF_SQL_BIT"/>,
referencetype  = <cfqueryparam value="#PosMediaBean.getReferenceType()#" cfsqltype="CF_SQL_TINYINT"/>,
referenceid  = <cfqueryparam value="#PosMediaBean.getReferenceID()#" cfsqltype="CF_SQL_INTEGER"/>,
mediaunit  =  mediaunit + <cfqueryparam value="#PosMediaBean.getMediaUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
mediaround  = mediaround + <cfqueryparam value="#PosMediaBean.getMediaRound()#" cfsqltype="CF_SQL_FLOAT"/>,
mediachange  = mediachange + <cfqueryparam value="#PosMediaBean.getMediaChange()#" cfsqltype="CF_SQL_FLOAT"/>,
mediaext  =  mediaext + <cfqueryparam value="#PosMediaBean.getMediaExt()#" cfsqltype="CF_SQL_FLOAT"/>,
mediatax  = mediatax + <cfqueryparam value="#PosMediaBean.getMediaTax()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		SequenceID = <cfqueryparam value="#PosMediaBean.getSequenceID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn PosMediaBean />
</cffunction>

</cfcomponent>