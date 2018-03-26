//= require moment 
//= require fullcalendar

$(document).ready(function(){
	$('#calendar').fullCalendar({
		events: '/admin/bookings.json?calendar_type=default'
	});

	$('#calendar-list_view').fullCalendar({
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
		events: '/admin/bookings.json?calendar_type=list_view'
	})
});
