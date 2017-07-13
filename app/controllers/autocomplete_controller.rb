class AutocompleteController < ApplicationController

  before_action :build_name_tree

  def show
    prefix = params[:prefix]
    res = Names.autocomplete(prefix)

    render json: res
  end

  private

  def build_name_tree
    if Names.name_tree.blank?
      Names.build_name_tree
    end
  end
end
