class Api::SearchesController < Api::ApplicationController
  include PgSearch
  def search
    @results = PgSearch.multisearch(params[:query])
    render template: "api/search"
  end
end
