class Api::SearchesController < Api::ApplicationController
  include PgSearch
  def search
    @results = PgSearch.multisearch(params[:query]).limit(7)
    render template: "api/search"
  end
end
