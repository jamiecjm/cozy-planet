//= require active_admin/base
//= require activeadmin_addons/all
//= require Chart.bundle
//= require chartkick
//= require_tree ./admin

$(window).on('load', function () {
  $('#active_admin_content').css('opacity', 1);
});



$(document).ready(function(){
scale_chart();

$(".col").each(function(){
  var attr = $(this).attr("class").replace(/col /, "");
  attr = attr.replace(/col-/, "");
  var data_label = attr.replace(/_/g, ' ');
  $(this).attr("data-label", data_label);
});

});

$(window).resize(scale_chart);

function scale_chart(){
	if($(window).width() <= 767){
	  scale = ($("#active_admin_content").width()-15)/1200;
	  $("#chart").css("transform", "scale("+scale+")");
	} else {
	  $("#chart").css("transform", "none");
	} 
} 


