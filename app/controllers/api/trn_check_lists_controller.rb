class Api::TrnCheckListsController < Api::ApiController
    # before_action :authenticate_user
  before_action :set_trn_check_list, only: [:show, :edit, :update, :destroy]



  def create
    begin
    checklists = params['checklists']
    trns_doc_no = params['trns_doc_no']
    checklists.each do |a|
      TrnCheckList.create!(trns_doc_no:trns_doc_no,loc:a['loc'],remark:a['input'],checked:a['checked'],check_list_code:a['check_list_code'],check_list_desc:a['check_list_desc'],status:a['status'])
    end
      render json: checklists, status: :created
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_list
    begin
    checklists = params['checklists']
    trns_doc_no = params['trns_doc_no']
    checklists.each do |a|
     trn =  TrnCheckList.where('trns_doc_no=?',trns_doc_no)
     puts trn.to_json
      if !trn.blank?
        puts "if"
        trn.update(trns_doc_no:trns_doc_no,loc:a['loc'],remark:a['input'],checked:a['checked'],check_list_code:a['check_list_code'],check_list_desc:a['check_list_desc'],status:a['status'])
      end
    end
      render json: checklists, status: :created
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_check_list
      @checklist = TrnCheckList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_check_list_params
        params.permit(:trns_doc_no,:loc,:check_list_code,:check_list_desc,:status)
    end
end