require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Test suit for GET /todos
  describe 'GET /todos' do
    # make HTTP get request before each example
    before { get '/todos' }

    it "return todos" do
      # Note 'json' is a custom helper to parse JSON responses
      expect(JSON).not_to be_empty
      expect(JSON.size).to eq(10)
    end

    it "return status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suit for GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'When record exists' do
      it "returns the todo" do
        expect(JSON).not_to be_empty
        expect(JSON['id']).to eq(todo_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "When record does not exists" do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Coudn't find Todo/)
      end
    end
  end
end
