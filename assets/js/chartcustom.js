
function renderGraph(data,graphtype,id,labels) {
  var canvas = document.getElementById(id);
  var ctx = canvas.getContext('2d');



  Chart.defaults.global.elements.point.hoverRadius = 10;
  var myChart = new Chart(ctx, {
      type: graphtype,
      data: {
        labels: labels,
          datasets: data
      },
options: {
          scales: {
            xAxes: [{
                type: 'time',
                position: 'bottom'
            }],
              yAxes: [{
                  ticks: {
                      beginAtZero:true,
                  }
              }]
          },
          tooltips: {
                mode: 'label'
          },
          elements: {
            line: {
              tension: 0.00000001,
            }
          }
       }, 
  });

}