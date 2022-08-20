module V1
    class JobappsController < ApplicationController
        before_action :set_job
        before_action :set_job_jobapp, only: [:show]

        # GET /jobs/:job_id/jobapps
        def index
            json_response(@job.jobapps)
        end

        # GET /jobs/:job_id/jobapps/:id
        def show
            json_response(@jobapp)
        end

        # POST /jobs/:job_id/jobapps
        #  Parameters: created_by
        def create
            @job.jobapps.create!(jobapp_params)
            json_response(@job, :created)
        end
        
        private

        def jobapp_params
            params.permit(:created_by)
        end

        def set_job
            @job = Job.find(params[:job_id])
        end

        def set_job_jobapp
            @jobapp = @job.jobapps.find_by!(id: params[:id]) if @job
        end
    end
end
