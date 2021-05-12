require "spec_helper"
require "tnw_common/services/solr"
require "tnw_common/solr/solr_query"

RSpec.describe TnwCommon::Services::Solr do
  let(:controller) { Class.new { extend TnwCommon::Services::Solr } }
  let(:brandon_search_array) {
    [["bk128d08z",
      "Register 5A f.77 (recto) entry 2",
      "cn69m436v",
      "Admission, Installation, Memorandum",
      "Register, Vacancy, Register, Sede Vacante",
      "Admission by John de Craucumbe [Crowcombe], vicar general of Archbishop Greenfield during his absence from his diocese, of Henry [Blunsdon], th
    e king's almoner, to the prebend of Saltmarsh (Saltmersk) in the church of Howden (Houedene), vacant by the death of Master Reginald de Braundon [
    <span class='highlight_text'>Brandon</span>], the previous prebendary, patron: prior and convent of Durham (Dunolm); with memorandum of a mandate
    to the keeper of the spiritualities of Howden for Henry's installation (two entries).",
      "",
      "Latin",
      "Admissions, Religious Patrons, Installations",
      "The heading 'Cleveland' at the top of this page presumably only related to the first entry, since the remaining entries are not connected with
    that archdeaconry.",
      "",
      "Brown, William, and A. Hamilton Thompson. (eds.). 1925. The Register of Thomas Corbridge, Lord Archbishop of York 1300-1304 Part II. Surtees So
    ciety 141, 176.",
      ["Place of person status: Howden, East Riding of Yorkshire, England (church); written as Houedene",
        "Benefice: Howden Minster, Saltmarsh Prebend, Yorkshire, England (prebend); written as Saltmersk",
        "Place of dating: Bishop Burton, East Riding of Yorkshire, England; written as Burton iuxta Beverl'"],
      ["Former incumbent: <span class='highlight_text'>Brandon</span>, Reginald, d c 1306, Prebendary of Saltmarsh (prebendary); written as Reginald de Braundon",
        "Issuer: Crowcombe, Master, John, d 1308, Archdeacon of the East Riding (vicar general, archdeacon); written as John de Craucumbe",
        "Mentioned: Edward I, 1239-1307, King of England (king)",
        "New incumbent: Blunsdon, Henry, d 1316, Archdeacon of Dorset (king's almoner); written as Henry",
        "Patron: Durham, St Cuthbert Priory, Benedictine (prior and convent); written as Dunolm"],
      ["Document date: 1306/03/23 (certain)"]],
      ["0k225f24s",
        "Register 7 f.183 (verso) entry 2",
        "0z708z00t",
        "Notification, Excommunication",
        "Archdeaconry of Cleveland",
        "Notification of excommunication of Richard, rector of Bossall (Bossale), William son of Sybil de Butercramb [Buttercrambe], John his servant and Adam de <span class='highlight_text'>Brandon</span>.",
        "",
        "",
        "Women",
        "",
        "",
        "Brown, William, and A. Hamilton Thompson. (eds.). 1936. The Register of William Greenfield Lord Archbishop of York 1306-1315 Part III. Surtees Society 151, 56.",
        ["Place of dating: Sutton upon Derwent, East Riding of Yorkshire, England (none given); written as Sutton super Derewent"],
        ["Excommunicated: <span class='highlight_text'>Brandon</span>, Adam, fl 1310 (none given)",
          "Excommunicated: Bossall, Richard, fl 1307, rector of Bossall (rector)",
          "Excommunicated: Buttercrambe, William, fl 1310, son of Sybil de Buttercrambe (son)",
          "Excommunicated: John, fl 1310, servant of William son of Sybil de Buttercrambe (servant)"],
        ["Document date: 1310/08/19 (certain)"]],
      ["9880vv162",
        "Register 7 f.184 (verso) entry 1",
        "z316q348h",
        "Notification",
        "Archdeaconry of Cleveland",
        "Notification by the commissary-general of the official of the court of York to the commissary-general of the official of York and the dean of Bulmer, of the excommunication of Richard, rector of Bossall (Bossale), William son of Sybil de Butercramb [Buttercrambe], John his servant and Adam de <span class='highlight_text'>Brandon</span> (insert).",
        "",
        "",
        "Women",
        "This is the face of the document.",
        "",
        "Brown, William, and A. Hamilton Thompson. (eds.). 1936. The Register of William Greenfield Lord Archbishop of York 1306-1315 Part III. Surtees Society 151, 56.",
        ["Place of dating: York City, York, York, England (none given); written as Ebor'"],
        [],
        ["Document date: 1310/08/08 (certain)"]]]
  }

  describe "When returns search results" do
    let (:search_result_arrays) { controller.set_search_result_arrays(search_term: "Brandon", display_type: "full display") }
    context "with full display" do
      it "matches Registers IDs" do
        expect(search_result_arrays[0][0]).to eq(brandon_search_array[0][0])
        expect(search_result_arrays[1][0]).to eq(brandon_search_array[1][0])
        expect(search_result_arrays[2][0]).to eq(brandon_search_array[2][0])
      end
    end
    # expect(search_result_arrays).to eq(brandon_search_array)
  end
end
