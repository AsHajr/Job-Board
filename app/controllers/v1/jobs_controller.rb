module V1
    class JobsController < ApplicationController
        before_action :set_job, only: [:show, :update, :destroy]
        load_and_authorize_resource

        # GET /jobs
        def index
            @jobs = Job.filter(params.slice(:id, :title, :created_by, :created_at, :updated_at))
            json_response(@jobs)
        end

        # POST /jobs
        def create
            @job = current_user.jobs.create!(job_params)
            json_response(@job, :created)
        end

        # GET /jobs/:id
        def show
            json_response(@job)
        end

        # PUT /jobs/:id
        def update
            @job.update(job_params)
            head :no_content
        end

        # DELETE /jobs/:id
        def destroy
            @job.destroy
            head :no_content
        end

        private

        def job_params
            params.permit(:title, :description)
        end

        def set_job
            @job = Job.find(params[:id])
        end
    end
end
