ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
        column do
            h2 'Reservations'
            div class: "timeline" do
                controller.instance_variable_get(:@dates).each do |key, value|
                    h3 key
                    div class: 'events' do
                        value.each_with_index do |object, index|
                            a href: admin_booking_path(object[1]), class: "event #{'event-start' if index == 0} #{'event-end' if index == value.length-1}" do
                                span object[1].guest
                                br
                                span 'Check In'
                                br
                                span object[1].unit.unit_no
                            end
                        end
                    end
                end
            end 
        end
        column
    end
  end # content

  controller do
    def index
        bookings = Booking.accessible_by(current_ability).where('check_in >= ?', Date.current).order(:check_in).limit(10)
        @dates = {}
        bookings.map {|b| 
            @dates[b.check_in.to_date] = {} if @dates[b.check_in.to_date].blank?
            index = @dates[b.check_in.to_date].length 
            @dates[b.check_in.to_date][index] = b
        }
    end
  end
end
