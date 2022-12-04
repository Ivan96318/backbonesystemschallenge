require 'csv'

module Api
  class ZipCodesController < ApplicationController
    def show
      path = File.join Rails.root, 'public'
      FileUtils.mkdir_p(path) unless File.exist?(path)
		  id = params[:id]
      file = File.open(File.join(path, 'zip_codes.txt'), 'r')
      zip_codes = []
      zips = file.readlines.select { |f|  f.start_with?(params[:id]) }
      zips.each do |z|
        a = z.encode("UTF-8", invalid: :replace, replace: "").split(/\s*\|\s*/)
        zip_codes.push({
          zip_code: a[0],
          locality: a[4],
          federal_entity: {
            key: a[7].to_i,
            name: a[5],
            code: nil,
          },
          settlements: [{
            key: a[12].to_i,
            name: a[1],
            zone_type: a[13],
            settlement_type: {
              name: a[2]
            }
          }],
          municipality: {
            key: a[11].to_i,
            name: a[3]
          }
        })
      end
      render json: zip_codes.to_json, status: 200
    end
  end
end