class Api::CheckListsController < Api::ApiController
    # before_action :authenticate_user

def fetch_lists
    begin
      records = CheckList.all
      doc_no = OsmIssueHdr.select('trns_doc_no').order('created_at desc').first
      trn_doc_no = OsmIssueHdr.select('trns_doc_no').order('updated_at desc').first
      list = TrnCheckList.all.where('trns_doc_no=?',trn_doc_no.trns_doc_no)
        if records.blank? 
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
           render json: {records: records, doc_no: doc_no,checklist:list }
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

    def fetch_trn_check_list
    begin
      doc_no = OsmIssueHdr.select('trns_doc_no').order('updated_at desc').first
      records = TrnCheckList.all.where('trns_doc_no=?',doc_no.trns_doc_no)
        if records.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
           render json: {records: records, doc_no: doc_no },status: :ok
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end