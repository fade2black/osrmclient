require 'spec_helper'

describe Osrmclient do
  it 'has a version number' do
    expect(Osrmclient::VERSION).not_to be nil
  end

  it "responds to 'locate'" do
    expect(subject).to respond_to(:locate)
  end

  it "responds to 'nearest'" do
    expect(subject).to respond_to(:nearest)
  end

  it "responds to 'viaroute'" do
    expect(subject).to respond_to(:viaroute)
  end

  it "responds to 'table'" do
    expect(subject).to respond_to(:table)
  end

  #lon:58.377067208892974, lat:37.91131446368779
  describe "Locating a node" do
    it "locates the nearest node point" do
      dbl = double("Osrmclient")
      allow(dbl).to receive(:locate ).with(lat:37.9113, lon:58.3771) {'{"mapped_coordinate":[37.911465,58.376976],"status":0}'}
      expect(dbl.locate(lat:37.9113, lon:58.3771)).to eq('{"mapped_coordinate":[37.911465,58.376976],"status":0}')
    end
  end

  describe "Nearest point on a street" do
    it "queries nearest point on a street segment" do
      dbl = double("Osrmclient")
      allow(dbl).to receive(:nearest ).with(lat:37.9113, lon:58.3771) {'{"name":"Atatürk köçesi","mapped_coordinate":[37.911289,58.377144],"status":0}'}
      expect(dbl.nearest(lat:37.9113, lon:58.3771)).to eq('{"name":"Atatürk köçesi","mapped_coordinate":[37.911289,58.377144],"status":0}')
    end
  end

  describe "Requesting routes" do
    it "queries point to point queries between the coordinates (lat1,lon1) and (lat2,lon2)" do
      resp = '{"hint_data":{"locations":["NvSCDET0ggwAAAAAOAAAAGEAAAAAAAAAAAAAAP____8AAAAA6zxCAlmQegMAABEA",
      "GfSCDDf0ggwAAAAAlQEAABcAAAAAAAAABgAAAEnXfQUAAAAAWkJCAjeIegMAABEA"],"checksum":1816229446},
      "route_name":["",""],"via_indices":[0,5],"via_points":[[37.895405,58.363991],[37.896793,58.361912]],
      "found_alternative":false,"route_summary":{"end_point":"","start_point":"","total_time":36,"total_distance":313},
      "route_geometry":"um}ggAqdginBkUwRikAjjClAdAhHhG","status_message":"Found route between points","status":0}'

      dbl = double("Osrmclient")
      allow(dbl).to receive(:viaroute ).with(lat1:37.8954, lon1:58.3640, lat2:37.8968, lon2:58.3619) { resp }
      expect(dbl.viaroute(lat1:37.8954, lon1:58.3640, lat2:37.8968, lon2:58.3619)).to eq(resp)
    end
  end

  describe "Distance tables" do
    it "requests distance tables" do
      resp = '{"distance_table":[[0,31090,31224,0],[31249,0,13138,31249],[31144,13188,0,31144],[0,31090,31224,0]]}'

      dbl = double("Osrmclient")
      allow(dbl).to receive(:table ).with(lat1:52.554070, lon1:13.160621, lat2:52.431272, lon2:13.720654, lat3:52.554070, lon3:13.720654, lat4:52.554070, lon4:13.160621) { resp }
      expect(dbl.table(lat1:52.554070, lon1:13.160621, lat2:52.431272, lon2:13.720654, lat3:52.554070, lon3:13.720654, lat4:52.554070, lon4:13.160621)).to eq(resp)
    end
  end

end
