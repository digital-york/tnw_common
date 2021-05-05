require "spec_helper"
require "tnw_common/services/solr"
require "tnw_common/solr/solr_query"

describe TnwCommon::Services::Solr do
  it "has pending solr service"
end

  it "returns search results" do
    expect(controller.set_search_result_arrays(search_term: "Brandon")).to eq("partial_list_array and other facets")
  end
end