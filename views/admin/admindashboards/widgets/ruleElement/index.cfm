<cfscript>
args.heading=args.heading?:"";
args.id=args.id?:"";
args.labels=serialize(args.labels)?:[];
</cfscript>

<cfif args.heading.len()>
  <cfoutput>
  <h4>#args.heading#</h4>
  </cfoutput>
</cfif>

<script>
<cfoutput>
var data = #args.data#;
var graphtype = '#args.graphtype#';
var id = '#args.id#';
var labels = #args.labels#	
</cfoutput>
renderGraph(data,graphtype,id,labels);

</script>

<cfoutput>
<canvas id="#args.id#"></canvas>
</cfoutput>



