ActiveAdmin.register ProfessionalAccountRequest do
    actions :index, :show, :edit, :update
    permit_params :username, :branch, :adress, :diploma, :first_cost, :follow_cost, :startAttendingTime, :endAttendingTime, :photo, :user_id, :confirmed
    index do
        selectable_column
        id_column
        column :photo
        column :username
        column :branch
        column :adress
        column :diploma
        column :first_cost
        column :follow_cost
        column :startAttendingTime
        column :endAttendingTime
        column :confirmed
        actions
    end
    show do
        attributes_table do
            row :photo
            row :username
            row :branch
            row :adress
            row :diploma
            row :first_cost
            row :follow_cost
            row :startAttendingTime
            row :endAttendingTime
            row :confirmed
        end
    end
    form do |f|
        f.semantic_errors
        f.inputs do
            f.input :username
            f.input :branch
            f.input :adress
            f.input :diploma
            f.input :first_cost
            f.input :follow_cost
            f.input :startAttendingTime
            f.input :endAttendingTime
            f.input :confirmed, as: :select, collection: ['pending', 'accepted']
            f.input :photo, as: :file
            f.input :user_id, as: :select, collection: User.all.map { |user| [user.email, user.id] }
        end
        f.actions
    end

    member_action :confirm_accepted, method: :put do
        resource.update(confirmed: true)
        redirect_to admin_professional_account_request_path(resource), notice: 'Professional account request confirmed.'
    end

    action_item :confirm_accepted, only: :show, if: -> { !resource.confirmed } do
        link_to 'Confirm Accepted', confirm_accepted_admin_professional_account_request_path(resource), method: :put
    end
end