<cfsilent>
<!----[
==========================================================================================================
Filename:      form_PosMediaBean.cfm
Description:   Form for  handling PosMedia Requires a bean called PosMediaBean to exist already.
Date:          4/April/2010 
Author:        Michael Kear

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfform name="PosMediaform" action="#cgi.SCRIPT_NAME#" method="post" format="xml" skin="#application.formskin#" scriptsrc="#application.scriptsource#" >
<cfformitem type="html">
<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
  <cfoutput>
  <div class="errorhandler"> #errorhandler.MakeErrorDisplay(errorhandler)# </div>
  </cfoutput>
</cfif>
</cfformitem>
<cfselect name="AllowChange" label="AllowChange">
<option value="1" <cfif #PosMediaBean.getAllowChange()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosMediaBean.getAllowChange()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="Description" label="Description" required="yes" message="Please provide the Description"  maxlength="50" style="width:400px;" value="#PosMediaBean.getDescription()#" />
<cfinput type="text" name="MediaChange" label="MediaChange" required="yes" message="Please provide the MediaChange" validate="float" style="width:400px;" value="#PosMediaBean.getMediaChange()#" />
<cfinput type="text" name="MediaExt" label="MediaExt" required="yes" message="Please provide the MediaExt" validate="float" style="width:400px;" value="#PosMediaBean.getMediaExt()#" />
<cfinput type="text" name="MediaID" label="MediaID" required="yes" message="Please provide the MediaID" validate="integer" style="width:400px;" value="#PosMediaBean.getMediaID()#" />
<cfinput type="text" name="MediaRound" label="MediaRound" required="yes" message="Please provide the MediaRound" validate="float" style="width:400px;" value="#PosMediaBean.getMediaRound()#" />
<cfinput type="text" name="MediaTax" label="MediaTax" required="yes" message="Please provide the MediaTax" validate="float" style="width:400px;" value="#PosMediaBean.getMediaTax()#" />
<cfinput type="text" name="MediaUnit" label="MediaUnit" required="yes" message="Please provide the MediaUnit" validate="float" style="width:400px;" value="#PosMediaBean.getMediaUnit()#" />
<cfinput type="text" name="PosTXID" label="PosTXID" required="yes" message="Please provide the PosTXID" validate="integer" style="width:400px;" value="#PosMediaBean.getPosTXID()#" />
<cfinput type="text" name="ReferenceID" label="ReferenceID" required="yes" message="Please provide the ReferenceID" validate="integer" style="width:400px;" value="#PosMediaBean.getReferenceID()#" />
<cfinput type="text" name="ReferenceType" label="ReferenceType" required="yes" message="Please provide the ReferenceType" validate="integer" style="width:400px;" value="#PosMediaBean.getReferenceType()#" />
<cfselect name="RoundTotal" label="RoundTotal">
<option value="1" <cfif #PosMediaBean.getRoundTotal()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosMediaBean.getRoundTotal()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="SequenceID" label="SequenceID" required="yes" message="Please provide the SequenceID" validate="integer" style="width:400px;" value="#PosMediaBean.getSequenceID()#" />
<cfselect name="TaxExempt" label="TaxExempt">
<option value="1" <cfif #PosMediaBean.getTaxExempt()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosMediaBean.getTaxExempt()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="submit" name="submit" value="Submit" class="submitbutton" />
</cfform>
