
<cfscript>
	param attributes.styleSheets = "";
	param attributes.javaScripts="";
	param attributes.js="";
	param attributes.css="";
	param attributes.jQueryLoad = true; 
	param attributes.cssLoad = true;
	param attributes.tableID = "cfDataTable";
	param attributes.class = "display compact";
	param attributes.style = "";
	param attributes.query = "";
	param attributes.filterDelay = "";
	param attributes.includeFilters = false;
	param attributes.autoWidth = true;
	param attributes.select = true;
	param attributes.dom = 'lBftip';
	param attributes.Export2Excel = true;
	param attributes.ExcelFileName = 'datatable_export';
	param attributes.callOnSelect ="";
	param attributes.identityColumn = "";
	param attributes.hideUntilComplete = true;
	
	ThisTag.uristyleSheets = ["css/jquery-ui.min.css",
								 "css/jquery.dataTables.min.css"];

	ThisTag.uriScripts = ["js/jquery.js",
						  "js/jquery.dataTables.min.js",
	 					  "extensions/Select/js/dataTables.select.min.js"];

	if(attributes.Export2Excel){
		ThisTag.uristyleSheets.addAll(["extensions/Buttons/css/buttons.jqueryui.min.css",
		"extensions/Buttons/css/buttons.dataTables.min.css"]);

		ThisTag.uriScripts.addAll(["extensions/Buttons/js/dataTables.buttons.min.js",
	 					  "extensions/Buttons/js/buttons.html5v2.js",
	 					  "extensions/jszip.min.js"]);
	}
								
	 					  

	 ThisTag.columns = "";//raw names
	 ThisTag.jsColumns = ""; //used in naming the columns in the def
	 ThisTag.headerCSS = "";
	 ThisTag.headerJS = "";
	 ThisTag.documentReadyPrefix = "<script>#chr(10)#$(function(){#chr(10)#";
	 ThisTag.documentReadyPostFix = "#chr(10)#});#chr(10)#</script>";
	 ThisTag.documentReadyScript = "";
	 ThisTag.buttonsPrefix = "";
	 ThisTag.buttonsPostfix = "";
	 ThisTag.excelButton = "";
	 //Structures and Arrays Populated with cf_datatablecolumn tags
	 ThisTag.columnDefinitions = [];
	 ThisTag.hiddenTargets ="";
	 ThisTag.noOrderTargets = "";
	 ThisTag.noSearchTargets ="";
	 ThisTag.outDefs = "";

	 ThisTag.widths = {};
	 ThisTag.types = {};
	 ThisTag.renderFunctions = {};

	 if(ThisTag.executionMode is "START"){
	 		if(attributes.cssLoad eq true){
		 		if(attributes.styleSheets neq ""){
				 	for (ThisTag.i = 1;ThisTag.i lte ListLen(attributes.styleSheets);ThisTag.i++){
				 		ArrayAppend(ThisTag.uristyleSheets,ListGetAt(attributes.styleSheets,ThisTag.i));
				 	}
				 }
		 		for(ThisTag.i = 1;ThisTag.i lte ArrayLen(ThisTag.uristyleSheets);ThisTag.i++){
		 			ThisTag.headerCSS = ListAppend(ThisTag.headerCSS,"<link rel='stylesheet' type='text/css' href='#ThisTag.uristyleSheets[ThisTag.i]#'></link>",chr(10));
		 		}
	 			GetPageContext().getCFOutput().writeHeader( ThisTag.headerCSS & chr(10) );
	 		}
	 		if(attributes.jQueryLoad eq true){
		 		if(attributes.javaScripts neq ""){
				 	for (ThisTag.i = 1;ThisTag.i lte ListLen(attributes.javaScripts);ThisTag.i++){
				 		ArrayAppend(ThisTag.uriScripts,ListGetAt(attributes.javaScripts,ThisTag.i));
				 	}
				 }
		 		for(ThisTag.i = 1;ThisTag.i lte ArrayLen(ThisTag.uriScripts);ThisTag.i++){

		 			ThisTag.headerJS = ListAppend(ThisTag.headerJS,"<script src='#ThisTag.uriScripts[ThisTag.i]#'></script>",chr(10));			 		
		 		}	
		 		 GetPageContext().getCFOutput().writeHeader( ThisTag.headerJS & chr(10) );
	 		}
	 }else{

	 	if(attributes.hideUntilComplete){
	 		ThisTag.styleHolder = attributes.style;
	 		attributes.style = "display: none;";
	 	}

	 	//Simplest Form, we just spit out the query
	 	if(isQuery(attributes.query)){
	 		ThisTag.columns = ArrayToList(attributes.query.getMeta().getColumnLabels());
	 	}

	 	if(StructKeyExists(ThisTag,"AssocAttribs")){
	 		for(subTag in ThisTag.AssocAttribs){
	 			ThisTag.i = ListFindNoCase(ThisTag.columns,subTag.Name);
	 			if(ThisTag.i eq 0){
	 				ThisTag.columns = ListAppend(ThisTag.columns,subTag.Name);
	 				ThisTag.i = ListLen(ThisTag.columns);
	 			}
	 			//JavaScript is a 0 based index, so we decrement
	 			ThisTag.i -= 1;
	 			if(subTag.Title neq ""){
	 				ArrayAppend(ThisTag.columnDefinitions,"{ 'title': '#subTag.Title#', 'targets': #ThisTag.i# }");
	 			}
	 			if(subTag.orderable eq false){
	 				ThisTag.noOrderTargets = ListAppend(ThisTag.noOrderTargets,ThisTag.i);
	 			}
	 			if(subTag.visible eq false){
	 				ThisTag.hiddenTargets = ListAppend(ThisTag.hiddenTargets,ThisTag.i);
	 			}
	 			if(subTag.searchable eq false){
	 				ThisTag.noSearchTargets = ListAppend(ThisTag.noSearchTargets,ThisTag.i);
	 			}

	 			if(subTag.type neq lcase("string")){
	 				if(! StructKeyExists(ThisTag.types,subtag.type)){
	 					ThisTag.types[subtag.type] = "";
	 				}
	 				ThisTag.types[subtag.type] = ListAppend(ThisTag.types[subtag.type],ThisTag.i);
	 			}
	 			if(subTag.width neq ""){
	 				if(! StructKeyExists(ThisTag.widths,subtag.width)){
	 					ThisTag.widths[subtag.width] = "";
	 				}
	 				ThisTag.widths[subtag.width] = ListAppend(ThisTag.widths[subtag.width],ThisTag.i);
	 			}
	 			if(subTag.renderFunction neq ""){
	 				if(! StructKeyExists(ThisTag.renderFunctions,subtag.renderFunction)){
	 					ThisTag.renderFunctions[subtag.renderFunction] = "";
	 				}
	 				ThisTag.renderFunctions[subtag.renderFunction] = ListAppend(ThisTag.renderFunctions[subtag.renderFunction],ThisTag.i);
	 			}
	 			if(subTag.className neq ""){
	 				if(! StructKeyExists(ThisTag.classNames,subtag.className)){
	 					ThisTag.classNames[subtag.className] = "";
	 				}
	 				ThisTag.classNames[subtag.className] = ListAppend(ThisTag.classNames[subtag.className],ThisTag.i);
	 			}
	 			
	 		}
	 	}


 		//Write the Table and Header
 		writeOutput("<table id='#attributes.tableID#' #iif(attributes.class neq "",DE("class='#attributes.class#'"),DE(""))# #iif(attributes.style neq "",DE("style='#attributes.style#'"),DE(""))#><thead><tr>");
 		for (ThisTag.i = 1;ThisTag.i lte listLen(ThisTag.columns);ThisTag.i++){
 			writeOutput("<th>#ListGetAt(ThisTag.columns,ThisTag.i)#</th>");
 			//Use this same loop for setting other column name variables
 			ThisTag.jsColumns = listAppend(ThisTag.jsColumns,"{name: '#ListGetAt(ThisTag.columns,ThisTag.i)#'}");
 		}
 		writeOutput("</tr></thead><tbody>");

 		//Write the Body
 		for (row in attributes.query){
 			writeoutput("<tr>");
 			for (column in ThisTag.columns){
 				writeOutput("<td>#row[column]#</td>");
 			}
 			writeoutput("</tr>");
 		}

 		writeOutput("</tbody><tfoot>");
 		for (ThisTag.i = 1;ThisTag.i lte listLen(ThisTag.columns);ThisTag.i++){
 			writeOutput("<th label='#ListGetAt(ThisTag.columns,ThisTag.i)#'></th>");
 		}
 		writeOutput("</tfoot></table>");
	 		


	 	if(!attributes.Export2Excel){
	 		attributes.dom = Replace(attributes.dom,"B","");
	 	}else{
	 		if(! Find("B",Attributes.dom)){
	 			attributes.dom = Insert("B",attributes.dom,2);
	 		}
	 		ThisTag.buttonsPrefix = "#chr(10)#,buttons: [{#chr(10)#";
	 		ThisTag.excelButton = "extend: 'excelHtml5',#chr(10)#title: '#attributes.ExcelFileName#',#chr(10)#exportOptions: {columns: ':visible',orthogonal: 'export',}";
	 		ThisTag.buttonsPostFix = "}]";
	 	}

	 	if(ThisTag.hiddenTargets neq ""){
	 		ArrayAppend(ThisTag.columnDefinitions,"{'visible': false, 'targets': [#ThisTag.hiddenTargets#]}");
	 	}
	 	if(ThisTag.noOrderTargets neq ""){
	 		ArrayAppend(ThisTag.columnDefinitions,"{'orderable': false, 'targets': [#ThisTag.noOrderTargets#]}");
	 	}
	 	if(ThisTag.noSearchTargets neq ""){
	 		ArrayAppend(ThisTag.columnDefinitions,"{'searchable': false, 'targets': [#ThisTag.noSearchTargets#]}");
	 	}
	 	//Widths, types and renderFunctions need special handling
	 	if(!StructIsEmpty(ThisTag.widths)){
 			ThisTag.widthKeys = StructKeyList(ThisTag.widths);
 			for(ThisTag.widthKey in ThisTag.widthKeys){
 				ArrayAppend(ThisTag.columnDefinitions,"{'width': '#ThisTag.widthKey#', 'targets': [#ThisTag.widths[ThisTag.widthKey]#]}");
 			}
 		}
 		if(!StructIsEmpty(ThisTag.types)){
 			ThisTag.typeKeys = StructKeyList(ThisTag.types);
 			for(ThisTag.typeKey in ThisTag.typeKeys){
 				ArrayAppend(ThisTag.columnDefinitions,"{'type': '#ThisTag.typeKey#', 'targets': [#ThisTag.types[ThisTag.typeKey]#]}");
 			}
 		}
 		if(!StructIsEmpty(ThisTag.renderFunctions)){
 			ThisTag.renderFunctionKeys = StructKeyList(ThisTag.renderFunctions);
 			for(ThisTag.renderFunctionKey in ThisTag.renderFunctionKeys){
 				ArrayAppend(ThisTag.columnDefinitions,"{'render': function ( data, type, row ) {return #ThisTag.renderFunctionKey#(data,type,row);},'targets': [#ThisTag.renderFunctions[ThisTag.renderFunctionKey]#]}");
 			}
 		}
	 	
	 	if(ArrayLen(ThisTag.columnDefinitions)){
	 		ThisTag.outDefs = ",'columnDefs':[" & ArrayToList(ThisTag.columnDefinitions,",#chr(10)#") &"]";
	 	}

	 
	 	savecontent variable="ThisTag.documentReadyScript" {

	 		WriteOutput(ThisTag.documentReadyPrefix); 		
	 		WriteOutput("o#attributes.tableID# = $('###attributes.tableID#').DataTable({
	 			 columns:[#ThisTag.jsColumns#]
	 			 #thisTag.outDefs#
	 			,autoWidth: #attributes.autoWidth#
	 			,select: #attributes.select#
	 			,dom: '#attributes.dom#'");
	 			if(ThisTag.buttonsPrefix neq ""){WriteOutput(ThisTag.buttonsPrefix);};
	 			if(attributes.Export2Excel){
	 				WriteOutput(ThisTag.excelButton);
	 			};
	 			if(ThisTag.buttonsPostfix neq ""){WriteOutput(ThisTag.buttonsPostfix);};
	 			
	 		WriteOutput("}
	 			);");

	 		if(attributes.select and attributes.identityColumn neq "" and attributes.callOnSelect neq ""){
	 			WriteOutput("			
			    o#attributes.tableID#.on('select', function( e,dt,type,indexes){			    	
					var idColumn = o#attributes.tableID#.column('#attributes.identityColumn#:name').index();				
			    	if(type === 'row'){		    	
			    		var rows = o#attributes.tableID#.rows( '.selected' ).indexes();
			    		for(i=0;i<rows.length;i++){
			    			var rowData = o#attributes.tableID#.row( rows[i] ).data();
			    			var uniqueID = rowData[idColumn];
			    			#attributes.callOnSelect#(uniqueID);	
			    		}	    				    		 
			    	}
			    });
	 		//} 
	 		");
	 		}

	 		if(attributes.includeFilters){
	 			WriteOutput("

	 			$('###attributes.tableID# tfoot th').each( function (i) {
			        var title = $(this).attr('label');
			        console.log(title);
			        $(this).html(#chr(34)#<input type='text' placeholder='Filter #chr(34)#+ title + #chr(34)#' />#chr(34)#);
			    } );

	 			 var flt#attributes.tableID# = $.fn.dataTable.util.throttle(
				    function ( idx,val ) {
				        o#attributes.tableID#.column(idx).search( val ).draw();
				    }");
	 			if(attributes.filterDelay neq ""){
	 				WriteOutput(",#attributes.filterDelay#");
	 			}
	 		
				WriteOutput(");");

			    WriteOutput("o#attributes.tableID#.columns().every( function () {
			        var that = this;
			 
			        $( 'input', this.footer() ).on( 'keyup change', function () {
			            if ( that.search() !== this.value ) {
				            	flt#attributes.tableID#(that.index(),this.value);
			            }
			        });
			    } );");    
	 		}
	 		
	 		if(attributes.hideUntilComplete){

		    	WriteOutput("$('###attributes.tableID#').css('display','block');#chr(10)#");
		    	if(ThisTag.styleHolder neq ""){
		    		WriteOutput("$('###attributes.tableID#).attr('style','#ThisTag.styleHolder#');");
		    	}
		    }
			
		   

	 		WriteOutput(ThisTag.documentReadyPostFix);
	 
	 };
	 		
	 	GetPageContext().getCFOutput().writeHeader( ThisTag.documentReadyScript);
	 

	 }
</cfscript>

