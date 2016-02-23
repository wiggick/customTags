	 <cfsetting showDebugOutput="No">

		<cfquery name ="q" datasource="AdventureWorks">
		select distinct top 300 BusinessEntityID, firstname,middlename,lastname from person.person	
		</cfquery>
	
		<html>
			<head>
				<style>
				.dExcel {float:right;}
				.dClear {clear: both;}
				</style>
				<script>
				function rowSelected(id){
					alert("the id of the row selected is "+ id);
				}

				function renderRed ( data, type, row ) {		                   
					if(type=="export"){
						return data;
					}else{
						return "<span style='color: red;'>" + data + "</span>";
                    }
                    
                    
                }
				</script>
			</head>
			<body>
				<div style="width: 800px; max-width: 800px;border: 5px solid">
				<cf_datatable query='#q#' dom='<"dExcel"B><"dClear">lftip' select='true' includeFilters='true' hideUntilComplete='true' callOnSelect='rowSelected' identityColumn='BusinessEntityID' filterDelay='2000'>
					<cf_datatablecolumn name="BusinessEntityID" visible="false"/>
					<cf_datatablecolumn name="firstname" title="First Name" />
					<cf_datatablecolumn name="middlename" title="Middle Name" Searchable="false" />
					<cf_datatablecolumn name="lastname"  title="Last Name" renderFunction="renderRed" orderable="false"/>
				</cf_datatable>
			</div>
			</body>
		</html>

