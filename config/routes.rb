Rails.application.routes.draw do
  # Routes for the Plan resource:

  get("/", {:controller=> "plans", :action=> "home"})

  # CREATE
  get("/make_plan",{ :controller=> "plans", :action => "makeit"})
  post("/insert_plan", { :controller => "plans", :action => "create" })
          
  # READ
  get("/plans", { :controller => "plans", :action => "index" })
  
  get("/plans/:path_id", { :controller => "plans", :action => "show" })
  
  # UPDATE
  
  post("/modify_plan/:path_id", { :controller => "plans", :action => "update" })
  
  # DELETE
  get("/delete_plan/:path_id", { :controller => "plans", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "users", :action => "new_registration_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "users", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "users", :action => "edit_registration_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "users", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "users", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_sessions", :action => "new_session_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_sessions", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_sessions", :action => "destroy_cookies" })
             
  #------------------------------

  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
