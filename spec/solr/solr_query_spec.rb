require 'spec_helper'
require 'tnw_common'
require 'tnw_common/solr/solr_query'

describe TnwCommon::Solr do
  solr_query = TnwCommon::Solr::SolrQuery.new('http://localhost:8983/solr/archbishops')
  it 'has a query method' do
    results = solr_query.query('*:*')
    expect(results).not_to be nil
  end
end
