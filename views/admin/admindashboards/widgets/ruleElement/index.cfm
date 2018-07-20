<cfscript>
args.heading=args.heading?:"";
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
</cfoutput>
renderGraph(data,graphtype);

</script>

<canvas id="canvas"></canvas>




