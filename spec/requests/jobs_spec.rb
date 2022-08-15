require 'rails_helper'

RSpec.describe "Jobs", type: :request do

  let(:user) { create(:user) }
  let!(:jobs) { create_list(:job, 10, created_by: user.id) }
  let(:job_id) { jobs.first.id }

  let(:headers) { valid_headers }

  describe 'GET /jobs' do
    
    context 'when the jobs are avaialable'do
      before { get '/jobs', params: {}, headers: headers }

      it 'returns jobs' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
      
    
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the jobs are expired' do
      let(:jobs) { create_list(:job, 10, created_by: user.id, expiry_date: Date.yesterday) }
      before { get '/jobs', params: {}, headers: headers }

        it 'does not return expired jobs' do
          expect(json.size).to eq(0)
        end
    end
  end

  describe 'GET /jobs/:id' do
    before { get "/jobs/#{job_id}", params: {}, headers: headers }


    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job with 'id'=11/)
      end
    end
  end

  describe 'POST /jobs' do
     let(:valid_attributes) do
      { title: 'job title', description:"job description", created_by: user.id.to_s }.to_json
    end

    context 'when the request is invalid (title is mssing)' do
      let(:invalid_attributes) { {title: nil, description: "job description" }.to_json }
      before { post '/jobs', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end

    context 'when the request is invalid (description is missing)' do
      let(:invalid_attributes) { {title:"job title", description: nil }.to_json }
      before { post '/jobs', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Description can't be blank/)
      end
    end

  end

  describe 'PUT /jobs/:id' do

     let(:valid_attributes) { { title: 'title', description: "description" }.to_json }

    context 'when the record exists & user is authorized' do
      before { put "/jobs/#{job_id}", params: valid_attributes, headers: headers }
      let (:job) {Job.find(job_id)}

      it 'make sure user is authorized' do
        expect(job["created_by"]).to eq(user.id.to_s)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

     context 'when the user is unauthorized' do
      let(:jobs) { create_list(:job, 10, created_by: (user.id+1)) }
      before { put "/jobs/#{job_id}", params: valid_attributes, headers: headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
