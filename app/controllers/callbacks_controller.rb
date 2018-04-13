class CallbacksController < Devise::OmniauthCallbacksController
  puts "=========================================Callbacks Controller=======================================================" * 10

  def google_oauth2
    puts "===========================================google_oauth2=====================================================" * 10
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    if @user
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      redirect_to admin_path, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, notice: 'Please login to perform that function'
    end
  end

end
