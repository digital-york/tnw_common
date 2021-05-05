require "spec_helper"
require "tnw_common/services/solr"
require "tnw_common/solr/solr_query"

RSpec.describe TnwCommon::Services::Solr do
  let(:controller) { Class.new { extend TnwCommon::Services::Solr } }
  it "returns five" do
    expect(controller.number).to eq(5)
  end

  it "returns search results" do
    expect(controller.set_search_result_arrays(search_term: "Brandon")).to eq("partial_list_array and other facets")
  end
end
