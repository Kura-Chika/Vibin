class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
end
