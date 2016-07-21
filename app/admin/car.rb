ActiveAdmin.register Car do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :title, :color, :year,
  details_attributes: [:id, :value, :kind, :_destroy]


filter :title
index do
  selectable_column
  column :title
  actions
end

form do |f|
    f.inputs do
      f.input :title
      f.input :year
      f.input :color
    end
    f.inputs do
      f.has_many :details, heading: 'Предложения', allow_destroy: true, new_record: true do |detail|
        detail.input :kind
        detail.input :value
      end
    end

    f.actions
end


end
