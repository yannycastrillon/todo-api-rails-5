# app/requests/items_spec.rb
require 'rails_helper'

RSpec.describe 'Items API' do
  let(:user) { create(:user) }
  # initialize the test data
  let(:todo)  { create(:todo, created_by: user.id) }
  let(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }
    context 'When items exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "returns all items" do
        expect(items.size).to eq(20)
      end
    end
    context "When items doesn't exits" do
      let(:todo_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Could/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    context 'When todo item exists' do
      it "returns a code status 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the item" do
        expect(json['id']).to eq(id)
      end
    end

    context "When tod o item does not valid" do
      let(:id) { 0 }
      it "returns a code status 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for POST /todos/:todo_id/items
  describe "POST /todos/:todo_id/items" do
    let(:valid_attributes) { { name:"Visit Narnia", done: false }.to_json }

    context "When request attributes are valid" do
      before { post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers }

      it "returns a code status 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "When an invalid request" do
      before { post "/todos/#{todo_id}/items", params: { } }
      it "returns a code status 422" do
        expect(response).to have_http_status(422)
      end
      it "returns a failure message" do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe "PUT /todos/:todo_id/items/:id" do
    let(:valid_attributes) { { name: "Mozart", params: valid_attributes, headers: headers } }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

    context "When item does exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
      it "updates the item" do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context "When item does not exists" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "return a not found message" do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suit DELETE /todos/:todo_id/items/:id
  describe "DELETE /todos/:todos_id/items/:id" do
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }
    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
