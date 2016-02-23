<!--- The cf_datatable column does nothing other than to collect attribute data --->
<cfscript>
	param attributes.name ="";
	param attributes.title = "";
	param attributes.width = "";
	param attributes.className = "";
	param attributes.type = "string";//date,num,num-fmt,html-num,html-num-fmt,html,string
	param attributes.visible = true;
	param attributes.orderable = true;
	param attributes.searchable = true;
	param attributes.renderFunction = "";

	if (listLast(getBasetagList()) != "cf_datatable"){
    	throw(type="UnmatchedEndTagException",
    		  message="Context validation error for the cf_datatablecolumn tag", 
    		  detail="The tag must be nested inside a cf_datatble tag.");
	}
</cfscript>
<cfassociate basetag="cf_datatable">
<cfexit method="exittag">