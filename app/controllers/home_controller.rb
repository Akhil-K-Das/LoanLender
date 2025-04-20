class HomeController < ApplicationController
    def index
        if current_user.admin?
            redirect_to admin_loans_path # or any other path you want for logged-in users
        else
            redirect_to user_loans_path
        end
    end
end
