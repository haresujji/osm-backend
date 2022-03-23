Rails.application.routes.draw do
   resources :route_masters
   namespace :api do  
    resources :trn_sfg_stocks do
      get :fetch_workcenter, on: :collection
      get :fetch_work_center_list, on: :collection
      get :fetch_rfid_list, on: :collection
      get :fetch_sap_batch, on: :collection
      get :fetch_sfg_list, on: :collection
      get :fetch_all_rfid, on: :collection
    end
    
    resources :trn_check_lists do
      get :fetch_trn_check_list, on: :collection
      patch :update_list, on: :collection
    end

    resources :check_lists do
      get :fetch_lists, on: :collection
    end

    resources :trucktype_masters do
      get :fetch_truck_code, on: :collection
      get :fetch_trucktypes, on: :collection
    end

    resources :transport_masters do 
       get :fetch_vendors, on: :collection
    end

    resources :trn_wip_stocks do
      get :fetch_workcenter, on: :collection
      get :fetch_work_center_list, on: :collection
    end

    resources :osm_issue_hdrs do
      get :fetch_trucknumber, on: :collection
      get :fetch_sto_list, on: :collection
      get :fetch_stos, on: :collection
      get :pagination_list, on: :collection
      get :fetch_search_hdrs, on: :collection
      patch :update_list, on: :collection
      patch :update_status, on: :collection
      get :fetch_transport_vendor, on: :collection
      get :fetch_docno, on: :collection
      get :fetch_docno_list, on: :collection
      get :fetch_sto_dtls, on: :collection
      get :fetch_hdrs, on: :collection
      patch :update_action_status, on: :collection
      patch :update_completed, on: :collection
      patch :update_truck_status, on: :collection
      patch :updatevehicle_time, on: :collection
      patch :update_truck_transfer, on: :collection
      get :fetch_current_date_object, on: :collection
      get :fetch_truck_details, on: :collection
      get :update_truck_details_admin, on: :collection
    end

    resources :osm_issue_dtls do
      get :fetch_issue_dtls, on: :collection
      get :fetch_docno_lists, on: :collection
      get :delete_issue_dtls, on: :collection
      get :fetch_dtls, on: :collection
      get :fetch_plantlocation, on: :collection
      get :fetch_wt, on: :collection
      patch :update_issue_status, on: :collection
      patch :update_excessstatus, on: :collection
      patch :update_new_sapbatch, on: :collection
      post :create_offline_dlts, on: :collection
    end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
