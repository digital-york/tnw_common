require 'spec_helper'
require 'tnw_common'
require 'tnw_common/solr/solr_query'

describe TnwCommon::Solr do
  it 'has a query method' do
    results = TnwCommon::Solr::SolrQuery.query('*:*')
    expect(results).not_to be nil
  end
end
