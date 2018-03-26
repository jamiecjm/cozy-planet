//= require moment 
//= require fullcalendar

$(document).ready(function(){
	var querystring = location.search
	if( querystring === ''){
		querystring = '?'
	} else {
		querystring += '&'
	}
	$('.index .calendar #calendar').fullCalendar({
		events: '/admin/bookings.json'+querystring+'calendar_type=default',
		displayEventTime: false,
		eventAfterRender: function (event, element, view) {
		    if (!$(element).hasClass('fc-start')){
		   		$(element, "a").css('color', $(element).css('background-color'));
		    }
		}
	});

	$('.index .calendar #calendar-list_view').fullCalendar({
		defaultView: 'listWeek',

		// customize the button names,
		// otherwise they'd all just say "list"
		views: {
		  listDay: { buttonText: 'list day' },
		  listWeek: { buttonText: 'list week' },
		  listMonth: { buttonText: 'list month' }
		},

		header: {
		  left: 'title',
		  center: '',
		  right: 'listDay,listWeek,listMonth'
		},
		events: '/admin/bookings.json'+querystring+'calendar_type=list_view'
	})
});
