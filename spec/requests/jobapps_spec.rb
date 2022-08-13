require 'rails_helper'

RSpec.describe "Jobapps", type: :request do
  
  let(:user) { create(:user) }
  let!(:job) { create(:job, created_by: user.id) }
  let!(:jobapps) { create_list(:jobapp, 20, job_id: job.id, created_by: user.id) }
  let(:job_id) { job.id }
  let(:id) { jobapps.first.id }

  let(:headers) { valid_headers }

  describe 'GET /jobs/:job_id/jobapps' do
    before { get "/jobs/#{job_id}/jobapps", params: {}, headers: headers }

    context 'when job exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all job jobapps' do
        expect(json.size).to eq(20)
      end
    end

    context 'when job does not exist' do
      let(:job_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job with 'id'=0/)
      end
    end
  end

  describe 'GET /jobs/:job_id/jobapps/:id' do
    before { get "/jobs/#{job_id}/jobapps/#{id}", params: {}, headers: headers }

    context 'when job jobapp exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the jobapp' do
        expect(json['id']).to eq(id)
      end
      
      it 'has status value' do
        expect(json['status']).to be_in([true, false])
      end
    end

    context 'when job jobapp does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(+"{\"message\":\"Couldn't find Jobapp with [WHERE \\\"jobapps\\\".\\\"job_id\\\" = ? AND \\\"jobapps\\\".\\\"id\\\" = ?]\"}")
      end
    end
  end

  # Test suite for POST /jobs/:job_id/jobapps
  describe 'POST /jobs/:job_id/jobapps' do
   let(:valid_attributes) {{created_by: user.id.to_s} .to_json }

    context 'when request attributes are valid' do
      before do
        post "/jobs/#{job_id}/jobapps", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/jobs/#{job_id}/jobapps", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end
end