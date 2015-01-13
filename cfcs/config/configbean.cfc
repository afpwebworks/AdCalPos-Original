<cfcomponent displayname="configbean" output="false" hint="A bean which models the configbean record.">

<cfsilent>
<!----
================================================================
Filename: configbean.cfc
Description: A bean which models the configbean record.
Author:  Michael Kear, AFP Webworks 
Date: 17/Jan/2008
================================================================
This bean was generated with the following template:
Bean Name: configbean
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	sitename string AFP
	DSN string AFPGeneric
	ftpDSN string staticstandalone
	BansDSN string Hawkradio
	mgmtReportCutoff numeric 5
	urlvar string pid
	mailserver string 
	mailuser string 
	mailpassword string 
	sitemailindex string 
	webmasteremail string 
	salesemail string 
	supportemail string 
	manageremail string 
	formskin string 
	scriptsource string /cfform/scripts
	revision number 1
	fckeditorbasepath string /cfform/scripts/fckeditor
	fckeditorConfig string
	approotURL string 
	approotABS string 
	cmsURL string 
	cmsABS string 
	dbABS string
	currentversion numeric 1
	uploaddirABS string 
	UserFilesAttachmentsABS string 
	UserfilesIconsABS string 
	UserfilesThumbnailsABS string 
	UserfilesPhotosABS string 
	uploaddirURL string 
	featureimagesABS string
	UserfilesAttachmentsURL string 
	UserfilesIconsURL string 
	UserfilesThumbnailsURL string 
	UserfilesPhotosURL string 
	hometimezone string Australia/Sydney
	timezone cfcs.utilities.TimeZone 
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="configbean" output="yes">
		<cfargument name="argsConfigXMLname" type="string" required="yes" />
		<cfargument name="sitename" type="string" required="false" default="AFP" />
		<cfargument name="DSN" type="string" required="false" default="AFPGeneric" />
        <cfargument name="FTPDSN" type="string" required="false" default="staticstandalone" />
		<cfargument name="BansDSN" type="string" required="false" default="HawekesburyRadio" />
        <cfargument name="mgmtReportCutoff" type="numeric" required="false" default="5" />
		<cfargument name="mailserver" type="string" required="false" default="" />
		<cfargument name="mailuser" type="string" required="false" default="" />
		<cfargument name="mailpassword" type="string" required="false" default="" />
		<cfargument name="sitemailindex" type="string" required="false" default="" />
		<cfargument name="webmasteremail" type="string" required="false" default="" />
		<cfargument name="salesemail" type="string" required="false" default="" />
		<cfargument name="supportemail" type="string" required="false" default="" />
		<cfargument name="manageremail" type="string" required="false" default="" />
		<cfargument name="formskin" type="string" required="false" default="" />
		<cfargument name="scriptsource" type="string" required="false" default="/cfform/scripts" />
		<cfargument name="fckeditorbasepath" type="string" required="false" default="/forms/fckeditor" />
		<cfargument name="fckeditorConfig" type="string" required="false" default="/forms/fckeditor/" />		
		<cfargument name="approotURL" type="string" required="false" default="" />
		<cfargument name="approotABS" type="string" required="false" default="" />
		<cfargument name="cmsURL" type="string" required="false" default="" />
		<cfargument name="cmsABS" type="string" required="false" default="" />
        <cfargument name="dbABS" type="string" required="false" default="" />
        <cfargument name="currentversion" type="numeric" required="false" default="1" />
		<cfargument name="uploaddirABS" type="string" required="false" default="" />
		<cfargument name="UserFilesAttachmentsABS" type="string" required="false" default="" />
		<cfargument name="UserfilesIconsABS" type="string" required="false" default="" />
		<cfargument name="UserfilesThumbnailsABS" type="string" required="false" default="" />
		<cfargument name="UserfilesPhotosABS" type="string" required="false" default="" />
		<cfargument name="UploaddirURL" type="string" required="false" default="" />
		<cfargument name="UserfilesAttachmentsURL" type="string" required="false" default="" />
		<cfargument name="UserfilesIconsURL" type="string" required="false" default="" />
		<cfargument name="UserfilesThumbnailsURL" type="string" required="false" default="" />
		<cfargument name="UserfilesPhotosURL" type="string" required="false" default="" />
        <cfargument name="hometimezone" type="string" required="false" default="Australia/Sydney" />		  
		<cfargument name="timezone" type="any" required="false" default="" /> 
		<cfset var siteversion = application.siteversion />
		<cffile action="read" 
				file="#expandPath(arguments.argsConfigXMLname)#"	 
				variable="rawconfigXML"/>
		<cfset configXML = xmlparse(rawconfigXML) />	
       
        	
		<cfscript>
			// run setters
			setSitename(configXML.settings[#siteversion#].sitename.xmltext);
			setDSN(configXML.settings[#siteversion#].DSN.xmltext);
			setFTPDSN(configXML.settings[#siteversion#].FTPDSN.xmltext);
			setBansDSN(configXML.settings[#siteversion#].BansDSN.xmltext);
			setmgmtReportCutoff(configXML.settings.globals.mgmtReportCutoff.xmltext);
			setcurrentversion(configXML.settings[#siteversion#].currentversion.xmltext);
			//setDSN("AFPWebworksIsntIT");
			// set base paths
			setCmsURL(configXML.settings[#siteversion#].cmsURL.xmltext);
			setCmsABS(configXML.settings[#siteversion#].cmsABS.xmltext);
			setApprootURL(configXML.settings[#siteversion#].approotURL.xmltext);
			setApprootABS(configXML.settings[#siteversion#].approotABS.xmltext);
			setdbABS(configXML.settings[#siteversion#].dbABS.xmltext);			
			//set email access variables
			setMailserver(configXML.settings[#siteversion#].mailserver.xmltext);
			setMailuser(configXML.settings[#siteversion#].mailuser.xmltext);
			setMailpassword(configXML.settings[#siteversion#].mailpassword.xmltext);
			setSitemailindex(configXML.settings[#siteversion#].sitemailindex.xmltext);
			setWebmasteremail(configXML.settings[#siteversion#].webmasteremail.xmltext);
			setSalesemail(configXML.settings[#siteversion#].salesemail.xmltext);
			setSupportemail(configXML.settings[#siteversion#].supportemail.xmltext);
			setManageremail(configXML.settings[#siteversion#].manageremail.xmltext);
			//set form variables
			setFormskin(configXML.settings.globals.formskin.xmltext);
			setScriptsource(configXML.settings[#siteversion#].scriptsource.xmltext);
			setfckeditorbasepath(configXML.settings.globals.fckeditorbasepath.xmltext);
			setfckeditorConfig(configXML.settings.globals.fckeditorConfig.xmltext);			
			//set absolute path variables
			setUploaddirABS(getCMSABS() & configXML.settings.paths.abs.uploaddir.xmltext);
			setUserFilesAttachmentsABS(getApprootABS() & configXML.settings.paths.abs.UserFiles.Attachments.xmltext);
			setUserfilesIconsABS(getApprootABS() & configXML.settings.paths.abs.Userfiles.Icons.xmltext);
			setUserfilesThumbnailsABS(getApprootABS() & configXML.settings.paths.abs.Userfiles.Thumbnails.xmltext);
			setUserfilesPhotosABS(getApprootABS() & configXML.settings.paths.abs.Userfiles.Photos.xmltext);
			//set URL path variables
			setUploaddirURL(getCMSURL() & configXML.settings.paths.URL.uploaddir.xmltext);			
			setUserfilesAttachmentsURL(getApprootURL() & configXML.settings.paths.URL.Userfiles.Attachments.xmltext);
			setUserfilesIconsURL(getApprootURL() & configXML.settings.paths.URL.Userfiles.Icons.xmltext);
			setUserfilesThumbnailsURL(getApprootURL() & configXML.settings.paths.URL.Userfiles.Thumbnails.xmltext);
			setUserfilesPhotosURL(getApprootURL() & configXML.settings.paths.URL.Userfiles.Photos.xmltext);
			//setTimezone(arguments.timezone);  ]---->
			setHomeTimeZone(configXML.settings.globals.hometimezone.xmltext);
			setTimezone(arguments.timezone);
			return this;
		</cfscript>

 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="errorHandler" output="false">
		<cfargument name="eH" required="true" type="errorHandler" />
<!-----[ validation parameters  (customise to suit) then remove comments 
			<!----[ sitename ]---->
			<cfif ( getSitename() eq whatever )>
				<cfset arguments.eH.setError("sitename", "sitename This is the error message") />
			</cfif>			
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setSitename" access="public" returntype="void" output="false">
		<cfargument name="sitename" type="string" required="true" />
		<cfset variables.instance.sitename = arguments.sitename />
		<cfset application.sitename = arguments.sitename />
	</cffunction>
	<cffunction name="getSitename" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitename />
	</cffunction>

	<cffunction name="setDSN" access="public" returntype="void" output="false">
		<cfargument name="DSN" type="string" required="true" />
		<cfset variables.instance.DSN = arguments.DSN />
		<cfset application.DSN = arguments.DSN />
	</cffunction>
	<cffunction name="getDSN" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DSN />
	</cffunction>
    
    <cffunction name="setFTPDSN" access="public" returntype="void" output="false">
		<cfargument name="FTPDSN" type="string" required="true" />
		<cfset variables.instance.FTPDSN = arguments.FTPDSN />
		<cfset application.FTPDSN = arguments.FTPDSN />
	</cffunction>
	<cffunction name="getFTPDSN" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FTPDSN />
	</cffunction>
	
	<cffunction name="setbansdsn" access="public" returntype="void" output="false">
		<cfargument name="bansdsn" type="string" required="true" />
		<cfset variables.instance.bansdsn = arguments.bansdsn />
		<cfset application.bansdsn = arguments.bansdsn />
	</cffunction>
	<cffunction name="getbansdsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.bansdsn />
	</cffunction>
    
    <cffunction name="setmgmtReportCutoff" access="public" returntype="void" output="false">
		<cfargument name="mgmtReportCutoff" type="numeric" required="true" />
		<cfset variables.instance.mgmtReportCutoff = arguments.mgmtReportCutoff />
		<cfset application.mgmtReportCutoff = arguments.mgmtReportCutoff />
	</cffunction>
	<cffunction name="getmgmtReportCutoff" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mgmtReportCutoff />
	</cffunction>
    
   	<cffunction name="setcurrentversion" access="public" returntype="void" output="false">
		<cfargument name="currentversion" type="numeric" required="true" />
		<cfset variables.instance.currentversion = arguments.currentversion />
		<cfset application.currentversion = arguments.currentversion />
	</cffunction>
	<cffunction name="getcurrentversion" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.currentversion />
	</cffunction>

	<cffunction name="setURLVar" access="public" returntype="void" output="false">
		<cfargument name="URLVar" type="string" required="true" />
		<cfset variables.instance.URLVar = arguments.URLVar />
		<cfset application.URLVar = arguments.URLVar />
	</cffunction>
	<cffunction name="getURLVar" access="public" returntype="string" output="false">
		<cfreturn variables.instance.URLVar />
	</cffunction>

	<cffunction name="setMailserver" access="public" returntype="void" output="false">
		<cfargument name="mailserver" type="string" required="true" />
		<cfset variables.instance.mailserver = arguments.mailserver />
		<cfset application.mailserver = arguments.mailserver />
	</cffunction>
	<cffunction name="getMailserver" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailserver />
	</cffunction>

	<cffunction name="setMailuser" access="public" returntype="void" output="false">
		<cfargument name="mailuser" type="string" required="true" />
		<cfset variables.instance.mailuser = arguments.mailuser />
		<cfset application.mailuser = arguments.mailuser />
	</cffunction>
	<cffunction name="getMailuser" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailuser />
	</cffunction>

	<cffunction name="setMailpassword" access="public" returntype="void" output="false">
		<cfargument name="mailpassword" type="string" required="true" />
		<cfset variables.instance.mailpassword = arguments.mailpassword />
		<cfset application.mailpassword = arguments.mailpassword />
	</cffunction>
	<cffunction name="getMailpassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailpassword />
	</cffunction>

	<cffunction name="setSitemailindex" access="public" returntype="void" output="false">
		<cfargument name="sitemailindex" type="string" required="true" />
		<cfset variables.instance.sitemailindex = arguments.sitemailindex />
		<cfset application.sitemailindex = arguments.sitemailindex />
	</cffunction>
	<cffunction name="getSitemailindex" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitemailindex />
	</cffunction>

	<cffunction name="setWebmasteremail" access="public" returntype="void" output="false">
		<cfargument name="webmasteremail" type="string" required="true" />
		<cfset variables.instance.webmasteremail = arguments.webmasteremail />
		<cfset application.webmasteremail = arguments.webmasteremail />
	</cffunction>
	<cffunction name="getWebmasteremail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.webmasteremail />
	</cffunction>

	<cffunction name="setSalesemail" access="public" returntype="void" output="false">
		<cfargument name="salesemail" type="string" required="true" />
		<cfset variables.instance.salesemail = arguments.salesemail />
		<cfset application.salesemail = arguments.salesemail />
	</cffunction>
	<cffunction name="getSalesemail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.salesemail />
	</cffunction>

	<cffunction name="setSupportemail" access="public" returntype="void" output="false">
		<cfargument name="supportemail" type="string" required="true" />
		<cfset variables.instance.supportemail = arguments.supportemail />
		<cfset application.supportemail = arguments.supportemail />
	</cffunction>
	<cffunction name="getSupportemail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.supportemail />
	</cffunction>

	<cffunction name="setManageremail" access="public" returntype="void" output="false">
		<cfargument name="manageremail" type="string" required="true" />
		<cfset variables.instance.manageremail = arguments.manageremail />
		<cfset application.manageremail = arguments.manageremail />
	</cffunction>
	<cffunction name="getManageremail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.manageremail />
	</cffunction>

	<cffunction name="setFormskin" access="public" returntype="void" output="false">
		<cfargument name="formskin" type="string" required="true" />
		<cfset variables.instance.formskin = arguments.formskin />
		<cfset application.formskin = arguments.formskin />
	</cffunction>
	<cffunction name="getFormskin" access="public" returntype="string" output="false">
		<cfreturn variables.instance.formskin />
	</cffunction>

	<cffunction name="setScriptsource" access="public" returntype="void" output="false">
		<cfargument name="scriptsource" type="string" required="true" />
		<cfset variables.instance.scriptsource = arguments.scriptsource />
		<cfset application.scriptsource = arguments.scriptsource />
	</cffunction>
	<cffunction name="getScriptsource" access="public" returntype="string" output="false">
		<cfreturn variables.instance.scriptsource />
		<cfset application.scriptsource = arguments.scriptsource />
	</cffunction>

	<cffunction name="setfckeditorbasepath" access="public" returntype="void" output="false">
		<cfargument name="fckeditorbasepath" type="string" required="true" />
		<cfset variables.instance.fckeditorbasepath = arguments.fckeditorbasepath />
		<cfset application.fckeditorbasepath = arguments.fckeditorbasepath />
	</cffunction>
	<cffunction name="getfckeditorbasepath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.fckeditorbasepath />
	</cffunction>
	
	<cffunction name="setfckeditorConfig" access="public" returntype="void" output="false">
		<cfargument name="fckeditorConfig" type="string" required="true" />
		<cfset variables.instance.fckeditorConfig = arguments.fckeditorConfig />
		<cfset application.fckeditorConfig = arguments.fckeditorConfig />
	</cffunction>
	<cffunction name="getfckeditorConfig" access="public" returntype="string" output="false">
		<cfreturn variables.instance.fckeditorConfig />
	</cffunction>
	
	<cffunction name="setApprootURL" access="public" returntype="void" output="false">
		<cfargument name="approotURL" type="string" required="true" />
		<cfset variables.instance.approotURL = arguments.approotURL />
		<cfset application.approotURL = arguments.approotURL />
	</cffunction>
	<cffunction name="getApprootURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.approotURL />
	</cffunction>

	<cffunction name="setApprootABS" access="public" returntype="void" output="false">
		<cfargument name="approotABS" type="string" required="true" />
		<cfset variables.instance.approotABS = arguments.approotABS />
		<cfset application.approotABS = arguments.approotABS />
	</cffunction>
	<cffunction name="getApprootABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.approotABS />
	</cffunction>

	<cffunction name="setCmsURL" access="public" returntype="void" output="false">
		<cfargument name="cmsURL" type="string" required="true" />
		<cfset variables.instance.cmsURL = arguments.cmsURL />
		<cfset application.cmsURL = arguments.cmsURL />
	</cffunction>
	<cffunction name="getCmsURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cmsURL />
	</cffunction>

	<cffunction name="setCmsABS" access="public" returntype="void" output="false">
		<cfargument name="cmsABS" type="string" required="true" />
		<cfset variables.instance.cmsABS = arguments.cmsABS />
		<cfset application.cmsABS = arguments.cmsABS />
	</cffunction>
	<cffunction name="getCmsABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cmsABS />
	</cffunction>

	<cffunction name="setdbABS" access="public" returntype="void" output="false">
		<cfargument name="dbABS" type="string" required="true" />
		<cfset variables.instance.dbABS = arguments.dbABS />
		<cfset application.dbABS = arguments.dbABS />
	</cffunction>
	<cffunction name="getdbABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dbABS />
	</cffunction>    

	<cffunction name="setUploaddirABS" access="public" returntype="void" output="false">
		<cfargument name="uploaddirABS" type="string" required="true" />
		<cfset variables.instance.uploaddirABS = arguments.uploaddirABS />
		<cfset application.uploaddirABS = arguments.uploaddirABS />
	</cffunction>
	<cffunction name="getUploaddirABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.uploaddirABS />
	</cffunction>

	<cffunction name="setUserFilesAttachmentsABS" access="public" returntype="void" output="false">
		<cfargument name="UserFilesAttachmentsABS" type="string" required="true" />
		<cfset variables.instance.UserFilesAttachmentsABS = arguments.UserFilesAttachmentsABS />
		<cfset application.UserFilesAttachmentsABS = arguments.UserFilesAttachmentsABS />
	</cffunction>
	<cffunction name="getUserFilesAttachmentsABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserFilesAttachmentsABS />
	</cffunction>

	<cffunction name="setUserfilesIconsABS" access="public" returntype="void" output="false">
		<cfargument name="UserfilesIconsABS" type="string" required="true" />
		<cfset variables.instance.UserfilesIconsABS = arguments.UserfilesIconsABS />
		<cfset application.UserfilesIconsABS = arguments.UserfilesIconsABS />
	</cffunction>
	<cffunction name="getUserfilesIconsABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesIconsABS />
	</cffunction>

	<cffunction name="setUserfilesThumbnailsABS" access="public" returntype="void" output="false">
		<cfargument name="UserfilesThumbnailsABS" type="string" required="true" />
		<cfset variables.instance.UserfilesThumbnailsABS = arguments.UserfilesThumbnailsABS />
		<cfset application.UserfilesThumbnailsABS = arguments.UserfilesThumbnailsABS />
	</cffunction>
	<cffunction name="getUserfilesThumbnailsABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesThumbnailsABS />
	</cffunction>

	<cffunction name="setUserfilesPhotosABS" access="public" returntype="void" output="false">
		<cfargument name="UserfilesPhotosABS" type="string" required="true" />
		<cfset variables.instance.UserfilesPhotosABS = arguments.UserfilesPhotosABS />
		<cfset application.UserfilesPhotosABS = arguments.UserfilesPhotosABS />
	</cffunction>
	<cffunction name="getUserfilesPhotosABS" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesPhotosABS />
	</cffunction>
    
	<cffunction name="setUploadDirURL" access="public" returntype="void" output="false">
		<cfargument name="UploadDirURL" type="string" required="true" />
		<cfset variables.instance.UploadDirURL = arguments.UploadDirURL />
		<cfset application.UploadDirURL = arguments.UploadDirURL />
	</cffunction>
	<cffunction name="getUploadDirURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UploadDirURL />
	</cffunction>

	<cffunction name="setUserfilesAttachmentsURL" access="public" returntype="void" output="false">
		<cfargument name="UserfilesAttachmentsURL" type="string" required="true" />
		<cfset variables.instance.UserfilesAttachmentsURL = arguments.UserfilesAttachmentsURL />
		<cfset application.UserfilesAttachmentsURL = arguments.UserfilesAttachmentsURL />
	</cffunction>
	<cffunction name="getUserfilesAttachmentsURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesAttachmentsURL />
	</cffunction>


	<cffunction name="setUserfilesIconsURL" access="public" returntype="void" output="false">
		<cfargument name="UserfilesIconsURL" type="string" required="true" />
		<cfset variables.instance.UserfilesIconsURL = arguments.UserfilesIconsURL />
		<cfset application.UserfilesIconsURL = arguments.UserfilesIconsURL />
	</cffunction>
	<cffunction name="getUserfilesIconsURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesIconsURL />
	</cffunction>

	<cffunction name="setUserfilesThumbnailsURL" access="public" returntype="void" output="false">
		<cfargument name="UserfilesThumbnailsURL" type="string" required="true" />
		<cfset variables.instance.UserfilesThumbnailsURL = arguments.UserfilesThumbnailsURL />
		<cfset application.UserfilesThumbnailsURL = arguments.UserfilesThumbnailsURL />
	</cffunction>
	<cffunction name="getUserfilesThumbnailsURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesThumbnailsURL />
	</cffunction>

	<cffunction name="setUserfilesPhotosURL" access="public" returntype="void" output="false">
		<cfargument name="UserfilesPhotosURL" type="string" required="true" />
		<cfset variables.instance.UserfilesPhotosURL = arguments.UserfilesPhotosURL />
		<cfset application.UserfilesPhotosURL = arguments.UserfilesPhotosURL />
	</cffunction>
	<cffunction name="getUserfilesPhotosURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserfilesPhotosURL />
	</cffunction>
    
   <!---[    <cffunction name="setRevision" access="public" returntype="void" output="false">
		<cfargument name="Revision" type="numeric" required="true" />
		<cfset variables.instance.Revision = arguments.Revision />
		<cfset application.Revision = arguments.Revision />
	</cffunction>
	<cffunction name="getRevision" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Revision />
	</cffunction>   ]---->

	<cffunction name="sethometimezone" access="public" returntype="void" output="false">
		<cfargument name="hometimezone" type="string" required="true" />
		<cfset variables.instance.hometimezone = arguments.hometimezone />
		<cfset application.hometimezone = arguments.hometimezone />
	</cffunction>
	<cffunction name="gethometimezone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.hometimezone />
	</cffunction>
	
  <cffunction name="setTimezone" access="public" returntype="void" output="false">
		<cfargument name="timezone" type="any" required="true" />
		<cfset variables.instance.timezone = arguments.timezone />
	</cffunction>
	<cffunction name="getTimezone" access="public" returntype="any" output="false">
		<cfreturn variables.instance.timezone />
	</cffunction> 
	
	<cffunction name="getAustime" access="public" returntype="any" output="no" hint="returns the current time (i.e. Australian time) in the local time zone">
	<cfreturn	getTimezone().castFromServer(now(),gethometimezone() ) />
	</cffunction>

</cfcomponent>