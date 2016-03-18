<cfscript>
	param attributes.styleSheets = '/js/datatables/bd.datatables.css';
	param attributes.javaScripts = '';
	param attributes.js = '';
	param attributes.css = '';
	param attributes.jQueryLoad = false; 
	param attributes.cssLoad = false;
	param attributes.tableDomID = 'cfDataTable';
	param attributes.class = 'display compact';
	param attributes.style = '';
	param attributes.query = '';
	param attributes.filterDelay = '';
	param attributes.includeFilters = false;
	param attributes.autoWidth = true;
	param attributes.select = true;
	param attributes.dom = 'lBftip';
	param attributes.Export2Excel = true;
	param attributes.ExcelFileName = 'datatable_export';
	param attributes.callOnSelect = '';
	param attributes.identityColumn = 'id';
	param attributes.hideUntilComplete = true;
	param attributes.theme = '';
	param attributes.searchDelay = '';
	param attributes.ajaxURL = '';
	param attributes.processingIndicator = true;

	param attributes.aryColumnInfo = []; //array of column information instead of using subtag cf_datatablecolumn

	ThisTag.jqueryUIThemes = "black-tie,blitzer,cupertino,dark-hive,dot-lub,eggplant,exicte-biek,flick,hot-sneaks,humanity,le-frog,mint-choc,overcast,pepper-grinder,redmond,smoothness,south-street,start,sunny,swanky-purse,trontastic,ui-darkeness,ui-lightness,vader";

	// "/js/datatables/bd.datatables.css",
	ThisTag.uristyleSheets = ["https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css",
							  "https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css",
							  "https://cdn.datatables.net/buttons/1.1.2/css/buttons.dataTables.min.css",
							  //"https://cdn.datatables.net/autofill/2.1.1/css/autoFill.dataTables.min.css",
							  //"https://cdn.datatables.net/colreorder/1.3.1/css/colReorder.dataTables.min.css",
							  //"https://cdn.datatables.net/fixedcolumns/3.2.1/css/fixedColumns.dataTables.min.css",
							  //"https://cdn.datatables.net/fixedheader/3.1.1/css/fixedHeader.dataTables.min.css",
							  //"https://cdn.datatables.net/keytable/2.1.1/css/keyTable.dataTables.min.css",
							  //"https://cdn.datatables.net/responsive/2.0.2/css/responsive.dataTables.min.css",
							  //"https://cdn.datatables.net/rowreorder/1.1.1/css/rowReorder.dataTables.min.css",
							  //"https://cdn.datatables.net/scroller/1.4.1/css/scroller.dataTables.min.css",
							  "https://cdn.datatables.net/select/1.1.2/css/select.dataTables.min.css"
							  ];


	ThisTag.uriScripts = ["https://code.jquery.com/jquery-2.2.1.min.js",
						  "https://code.jquery.com/ui/1.11.4/jquery-ui.min.js",
						  "https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js",
						 
						  //Extensions
						  //"https://cdn.datatables.net/autofill/2.1.1/js/dataTables.autoFill.min.js",
						  "https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js",
						  //"https://cdn.datatables.net/buttons/1.1.2/js/buttons.colVis.min.js",
						  //"https://cdn.datatables.net/buttons/1.1.2/js/buttons.flash.min.js",
						  "https://cdn.datatables.net/buttons/1.1.2/js/buttons.html5.min.js",
						   //"/js/datatables/1.10.10/extensions/Buttons/js/buttons.html5v2.js"
						  //"https://cdn.datatables.net/buttons/1.1.2/js/buttons.print.min.js",
						  //"https://cdn.datatables.net/colreorder/1.3.1/js/dataTables.colReorder.min.js",
						  //"https://cdn.datatables.net/fixedcolumns/3.2.1/js/dataTables.fixedColumns.min.js",
						  //"https://cdn.datatables.net/fixedheader/3.1.1/js/dataTables.fixedHeader.min.js",
						  //"https://cdn.datatables.net/keytable/2.1.1/js/dataTables.keyTable.min.js",
						  //"https://cdn.datatables.net/responsive/2.0.2/js/dataTables.responsive.min.js",
						  //"https://cdn.datatables.net/rowreorder/1.1.1/js/dataTables.rowReorder.min.js",
						  //"https://cdn.datatables.net/scroller/1.4.1/js/dataTables.scroller.min.js",
						  "https://cdn.datatables.net/select/1.1.2/js/dataTables.select.min.js"
						  //"https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"

						  	//Plugins
						    //cdn.datatables.net/plug-ins/1.10.11/api/average().js
							//cdn.datatables.net/plug-ins/1.10.11/api/column().title().js
							//cdn.datatables.net/plug-ins/1.10.11/api/columns().order().js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnAddDataAndDisplay.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnAddTr.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnColumnIndexToVisible.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnDataUpdate.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnDisplayRow.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnDisplayStart.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFakeRowspan.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFilterAll.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFilterClear.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFilterOnReturn.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFindCellRowIndexes.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnFindCellRowNodes.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetAdjacentTr.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetColumnData.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetColumnIndex.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetHiddenNodes.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetTd.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnGetTds.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnLengthChange.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnMultiFilter.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnPagingInfo.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnProcessingIndicator.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnReloadAjax.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnSetFilteringDelay.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnSortNeutral.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnStandingRedraw.js
							//cdn.datatables.net/plug-ins/1.10.11/api/fnVisibleToColumnIndex.js
							//cdn.datatables.net/plug-ins/1.10.11/api/order.neutral().js
							//cdn.datatables.net/plug-ins/1.10.11/api/page.jumpToData().js
							//cdn.datatables.net/plug-ins/1.10.11/api/processing().js
							//cdn.datatables.net/plug-ins/1.10.11/api/row().show().js
							//cdn.datatables.net/plug-ins/1.10.11/api/sum().js
					  ];

	if (attributes.cssLoad and attributes.theme neq "" and ListFind(ThisTag.jqueryUIThemes,attributes.theme)){
		ArrayAppend(ThisTag.uriStyleSheets,"https://code.jquery.com/ui/1.11.4/themes/#attributes.theme#/jquery-ui.css");
		ArrayAppend(ThisTag.uriStyleSheets,"https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.11/css/dataTables.jqueryui.css");
		ArrayAppend(ThisTag.uriScripts,"https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.11/js/dataTables.jqueryui.min.js");
	}
	
	 ThisTag.columns = "";//raw names
	 ThisTag.ajaxColumns = ""; //formatted for Ajax
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
	 ThisTag.delayValue = "";
	 ThisTag.ajaxValue = "";

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

	 	
		if(! StructKeyExists(ThisTag,"AssocAttribs") and ArrayLen(attributes.aryColumnInfo) gt 0){
			ThisTag.AssocAttribs = attributes.aryColumnInfo;
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
	 			if(StructKeyExists(subTag,"Title") and subTag.Title neq ""){
	 				ArrayAppend(ThisTag.columnDefinitions,"{ 'title': '#subTag.Title#', 'targets': #ThisTag.i# }");
	 			}
	 			if(StructKeyExists(subTag,"orderable") and subTag.orderable eq false){
	 				ThisTag.noOrderTargets = ListAppend(ThisTag.noOrderTargets,ThisTag.i);
	 			}
	 			if(StructKeyExists(subTag,"visible") and subTag.visible eq false){
	 				ThisTag.hiddenTargets = ListAppend(ThisTag.hiddenTargets,ThisTag.i);
	 			}
	 			if(StructKeyExists(subTag,"searchable") and subTag.searchable eq false){
	 				ThisTag.noSearchTargets = ListAppend(ThisTag.noSearchTargets,ThisTag.i);
	 			}

	 			if(StructKeyExists(subTag,"type") and subTag.type neq lcase("string")){
	 				if(! StructKeyExists(ThisTag.types,subtag.type)){
	 					ThisTag.types[subtag.type] = "";
	 				}
	 				ThisTag.types[subtag.type] = ListAppend(ThisTag.types[subtag.type],ThisTag.i);
	 			}
	 			if(StructKeyExists(subTag,"width") and subTag.width neq ""){
	 				if(! StructKeyExists(ThisTag.widths,subtag.width)){
	 					ThisTag.widths[subtag.width] = "";
	 				}
	 				ThisTag.widths[subtag.width] = ListAppend(ThisTag.widths[subtag.width],ThisTag.i);
	 			}
	 			if(StructKeyExists(subTag,"renderFunction") and subTag.renderFunction neq ""){
	 				if(! StructKeyExists(ThisTag.renderFunctions,subtag.renderFunction)){
	 					ThisTag.renderFunctions[subtag.renderFunction] = "";
	 				}
	 				ThisTag.renderFunctions[subtag.renderFunction] = ListAppend(ThisTag.renderFunctions[subtag.renderFunction],ThisTag.i);
	 			}
	 			if(StructKeyExists(subTag,"className") and subTag.className neq ""){
	 				if(! StructKeyExists(ThisTag.classNames,subtag.className)){
	 					ThisTag.classNames[subtag.className] = "";
	 				}
	 				ThisTag.classNames[subtag.className] = ListAppend(ThisTag.classNames[subtag.className],ThisTag.i);
	 			}
	 			
	 		}
	 	}

	 	 if(attributes.searchDelay neq ''){
			 ThisTag.delayValue=",searchDelay:#attributes.searchDelay#";
		}

	    if(attributes.ajaxURL neq ''){
	    	savecontent variable="ThisTag.ajaxValue" {
	    		WriteOutput(
				",bServerSide:true
				,ajax: {   
			    			url: '#attributes.ajaxURL#',
			    			type: 'POST',
			    			data: function (d) {return {'d': JSON.stringify(d) }; }

			    		}
				");
	    	};		 	
	    }

	

 		//Write the Table and Header
 		writeOutput("<table id='#attributes.tableDomID#' #iif(attributes.class neq "",DE("class='#attributes.class#'"),DE(""))# #iif(attributes.style neq "",DE("style='#attributes.style#'"),DE(""))#><thead><tr>");
 		for (ThisTag.i = 1;ThisTag.i lte listLen(ThisTag.columns);ThisTag.i++){
 			writeOutput("<th name='#ListGetAt(ThisTag.columns,ThisTag.i)#'>#ListGetAt(ThisTag.columns,ThisTag.i)#</th>");
 			//Use this same loop for setting other column name variables
 			if(attributes.ajaxURL neq ""){
 				ThisTag.jsColumns = listAppend(ThisTag.jsColumns,"{data: '#ListGetAt(ThisTag.columns,ThisTag.i)#'}");
 				ArrayAppend(ThisTag.columnDefinitions,"{name: '#ListGetAt(ThisTag.columns,ThisTag.i)#','targets': [#ThisTag.i - 1#]}");
 			}else{
 				ThisTag.jsColumns = listAppend(ThisTag.jsColumns,"{name: '#ListGetAt(ThisTag.columns,ThisTag.i)#'}");
 			}
 		}
 	

 		//Write the Body
 		if(attributes.ajaxURL eq ''){
 			writeOutput("<tbody>");
	 		for (row in attributes.query){
	 			writeoutput("<tr>");
	 			for (column in ThisTag.columns){
	 				writeOutput("<td>#row[column]#</td>");
	 			}
	 			writeoutput("</tr>");
	 		}
	 		writeOutput("</tbody>");
	 	}
 		writeOutput("<tfoot>");
 		for (ThisTag.i = 1;ThisTag.i lte listLen(ThisTag.columns);ThisTag.i++){
 			writeOutput("<th label='#ListGetAt(ThisTag.columns,ThisTag.i)#'></th>");
 		}
 		writeOutput("</tfoot></table>");
	 		


	 	if(!attributes.Export2Excel){
	 		//attributes.dom = Replace(attributes.dom,"B","");
	 	}else{
	 		//if(! Find("B",Attributes.dom)){
	 		//	attributes.dom = Insert("B",attributes.dom,2);
	 		//}
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
	 		WriteOutput("o#attributes.tableDomID# = $('###attributes.tableDomID#').DataTable({
	 			 bProcessing:#attributes.processingIndicator#
	 			 #thisTag.delayValue#
	 			 #thisTag.ajaxValue#");

	 
	 		writeOutput(',"language": {
	            "lengthMenu": "Show _MENU_ entries",
	            "zeroRecords": "Nothing found - sorry",
	            "info": "Showing page _PAGE_ of _PAGES_",
	            "infoEmpty": "No records available",
	            "infoFiltered": "<br>(filtered from _MAX_ total records)"
	        }');

	 			
			WriteOutput(",columns:[#ThisTag.jsColumns#]");
	 		
	 		WriteOutput("#thisTag.outDefs#
	 			,autoWidth: #attributes.autoWidth#
	 			,select: #attributes.select#
	 			,drawCallback: function(settings){
					if(settings._iRecordsDisplay >= settings._iDisplayLength){
						$('.dataTables_paginate').show();
					}else{
						$('.dataTables_paginate').hide();
					}
					
    				//console.log(settings);
    			}
	 			,dom: '#attributes.dom#'");
	 			if(ThisTag.buttonsPrefix neq ""){WriteOutput(ThisTag.buttonsPrefix);};
	 			if(attributes.Export2Excel){
	 				WriteOutput(ThisTag.excelButton);
	 			};
	 			if(ThisTag.buttonsPostfix neq ""){WriteOutput(ThisTag.buttonsPostfix);};
	 			
	 		WriteOutput("}
	 			);");

	 		

	 		if(attributes.select and attributes.identityColumn neq "" and attributes.callOnSelect neq ""){
				if(attributes.ajaxURL neq ""){
					WriteOutput("			
					    o#attributes.tableDomID#.on('select', function( e,dt,type,indexes){		
							
					    	if(type === 'row'){		    	
					    		var rows = o#attributes.tableDomID#.rows( '.selected' ).indexes();
					    		for(i=0;i<rows.length;i++){
					    			var rowData = o#attributes.tableDomID#.row( rows[i] ).data();
					    			//this changes depending if it's an ajax callOnSelect
					    			//rowdata is ajax and is an object with key/value pairs
				    				var uniqueID = rowData['#attributes.identityColumn#'];
					    						    			
					    			#attributes.callOnSelect#(uniqueID);	
					    		}	    				    		 
					    	}
					    });	
			 		");
				}else{
			 		WriteOutput("			
					    o#attributes.tableDomID#.on('select', function( e,dt,type,indexes){		
			  				
							var idColumn = o#attributes.tableDomID#.column('#attributes.identityColumn#:name').index();	
							
					    	if(type === 'row'){		    	
					    		var rows = o#attributes.tableDomID#.rows( '.selected' ).indexes();
					    		for(i=0;i<rows.length;i++){
					    			var rowData = o#attributes.tableDomID#.row( rows[i] ).data();
					    			var uniqueID = rowData[idColumn];	    			
					    			#attributes.callOnSelect#(uniqueID);	
					    		}	    				    		 
					    	}
					    });	
			 		");
			 	}
	 		}

	 		if(attributes.includeFilters){
	 			WriteOutput("

	 			$('###attributes.tableDomID# tfoot th').each( function (i) {
			        var title = $(this).attr('label');
			        //console.log(title);
			        $(this).html(#chr(34)#<input type='text' placeholder='Filter #chr(34)#+ title + #chr(34)#' />#chr(34)#);
			    } );

	 			 var flt#attributes.tableDomID# = $.fn.dataTable.util.throttle(
				    function ( idx,val ) {
				        o#attributes.tableDomID#.column(idx).search( val ).draw();
				    }");
	 			if(attributes.filterDelay neq ""){
	 				WriteOutput(",#attributes.filterDelay#");
	 			}
	 		
				WriteOutput(");");

			    WriteOutput("o#attributes.tableDomID#.columns().every( function () {
			        var that = this;
			 
			        $( 'input', this.footer() ).on( 'keyup change', function () {
			            if ( that.search() !== this.value ) {
				            	flt#attributes.tableDomID#(that.index(),this.value);
			            }
			        });
			    } );");    
	 		}
	 		
	 		if(attributes.hideUntilComplete){

		    	WriteOutput("$('###attributes.tableDomID#').css('display','block');#chr(10)#");
		    	if(ThisTag.styleHolder neq ""){
		    		WriteOutput("$('###attributes.tableDomID#).attr('style','#ThisTag.styleHolder#');");
		    	}
		    }
			
		   

	 		WriteOutput(ThisTag.documentReadyPostFix);
	 
	 };
	 	try{
	 		GetPageContext().getCFOutput().writeHeader( ThisTag.documentReadyScript);
	 	}
	 	catch(any e){
	 		//header may have already been written out 
	 		WriteOutput(ThisTag.documentReadyScript);
	 	}

	 }
</cfscript>
