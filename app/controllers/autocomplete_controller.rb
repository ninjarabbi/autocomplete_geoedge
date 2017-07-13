class AutocompleteController < ApplicationController

  before_action :check_params, :build_name_tree, only: :show

  def show
    prefix = params[:prefix]
    result = Names.autocomplete(prefix)

    render json: result
  end


  def add_names
    added_counter = 0
    if params[:names]
      added_counter = Names.add_names(params[:names])
    end

    render json: {success: "added #{added_counter} names"}, status: :ok
  end


  private

  def check_params
    if params[:prefix].nil?
      render json: {error: 'Please provide a string to complete.'}, status: :bad_request
    end
  end

  def build_name_tree
    if Names.name_tree.blank?
      Names.build_name_tree
    end
  end
end
