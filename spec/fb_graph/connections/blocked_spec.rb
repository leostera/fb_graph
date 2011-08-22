require 'spec_helper'

describe FbGraph::Connections::Blocked do
  let(:page) { FbGraph::Page.new('FbGraph', :access_token => 'access_token') }
  let(:user) { FbGraph::User.new(579612276) }

  describe '#blocked' do
    it 'should return blocked users as FbGraph::User' do
      mock_graph :get, 'FbGraph/blocked', 'pages/blocked/index', :access_token => 'access_token' do
        users = page.blocked
        users.each do |user|
          user.should be_a FbGraph::User
        end
      end
    end
  end

  describe '#blocked?' do
    context 'when blocked' do
      it 'should retrun true' do
        mock_graph :get, 'FbGraph/blocked/579612276', 'pages/blocked/show_blocked', :access_token => 'access_token' do
          page.blocked?(user).should be_true
        end
      end
    end

    context 'otherwise' do
      it 'should retrun false' do
        mock_graph :get, 'FbGraph/blocked/579612276', 'pages/blocked/show_non_blocked', :access_token => 'access_token' do
          page.blocked?(user).should be_false
        end
      end
    end
  end

  describe '#block!' do
    it 'should return blocked users as FbGraph::User' do
      mock_graph :post, 'FbGraph/blocked', 'pages/blocked/create', :access_token => 'access_token', :params => {
        :uid => '579612276'
      } do
        blocked = page.block! user
        blocked.each do |user|
          user.should be_a FbGraph::User
        end
      end
    end

    it 'should support String as user identifier' do
      mock_graph :post, 'FbGraph/blocked', 'pages/blocked/create', :access_token => 'access_token', :params => {
        :uid => '579612276'
      } do
        blocked = page.block! '579612276'
        blocked.each do |user|
          user.should be_a FbGraph::User
        end
      end
    end
  end

  describe '#unblock!' do
    it 'should return true' do
      mock_graph :delete, 'FbGraph/blocked/579612276', 'true', :access_token => 'access_token' do
        page.unblock!(user).should be_true
      end
    end
  end
end