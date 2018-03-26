ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      panel "Calender", class: 'calendar' do
        columns do
          column do
            div id: 'calendar'
          end
          column do
            div id: 'calendar-list_view'
          end
        end
      end
    end
  end # content
end
