ActiveAdmin.register ProfessionalAccountRequest do
    actions :index, :show, :edit
    permit_params :username, :branch, :adress, :diploma, :first_cost, :follow_cost, :startAttendingTime, :endAttendingTime, :photo, :user_id, :confirmed, :latitude, :longitude
    index do
        selectable_column
        id_column
        column :username
        column :branch
        column :adress
        column :latitude 
        column :longitude
        column :diploma
        column :first_cost
        column :follow_cost
        column :confirmed
        actions
    end
    show do
        attributes_table do
            row :username
            row :branch
            row :adress
            row :latitude 
            row :longitude
            row :diploma
            row :first_cost
            row :follow_cost
            row :confirmed
        end
    end
    form do |f|
        f.semantic_errors
        f.inputs do
            f.input :username
            f.input :branch
            f.input :adress
            f.input :latitude 
            f.input :longitude
            f.input :diploma
            f.input :first_cost
            f.input :follow_cost
            f.input :confirmed, as: :select, collection: [[true, 'Accepted'], [false, 'Pending']]
            f.input :user_id, as: :select, collection: User.all.map { |user| [user.email, user.id] }
        end
        f.actions
    end
end