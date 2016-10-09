CN_CODE = '100000'
BJ_CODE = '110000'
TJ_CODE = '120000'
SH_CODE = '310000'
CQ_CODE = '500000'

ZXS_ARY = [BJ_CODE, TJ_CODE, SH_CODE, CQ_CODE]

namespace :init do
  desc "import nations from json file"
  task import_nations: :environment do
    CityCodesParser.new("lib/3rds/china_code.txt").parse
  end
end

module Ext
  def is_under_zxs?(code)
    ZXS_ARY.include? code
  end
end

class CityCodesParser
  include Ext
  def initialize(file_path)
    @source_file = File.open(file_path)
    @areas = Array.new
  end

  def parse
    read_file
    write_to_database
  end

  private

  def read_file
    @source_file.each do |line|
      line_as_array = LineAsArray.new(line.split(' '))
      line_as_array.is_province? ? @areas << province_parse(line_as_array) : city_parse(line_as_array)
    end
  end

  def write_to_database
    @areas.each do |province|
      @nation = Nation.create(name: province[:name], code: province[:code], admin_code: CN_CODE, tag: 1, parent_id: nil)
      province[:cities].each do |city|
        if ZXS_ARY.include? city[:code]
          @city = Nation.create(name: city[:name], code: city[:code].to_i + 100, admin_code: @nation.code, tag: 2, parent_id: @nation.id)
        else
          @city = Nation.create(name: city[:name], code: city[:code], admin_code: @nation.code, tag: 2, parent_id: @nation.id)
        end
        city[:counties].each do |country|
          @country = Nation.create(name: country[:name], code: country[:code], admin_code: @city.code, tag: 3, parent_id: @city.id)
        end
      end
    end
  end

  def close_file
    @source_file.close
  end

  def province_parse(line_as_array)
    province = line_as_array.build_province
    province[:cities] << build_city(line_as_array.code, line_as_array) if is_under_zxs?(line_as_array.code.to_s)
    province
  end

  def city_parse(line_as_array)
    if province = find_province(line_as_array.parent_code) # 这里是能找到 省 一级 (找不到的自然就归为 区县 一级)
      is_under_zxs?(province[:code]) ? province[:cities].first[:counties] << line_as_array.build_country : province[:cities] << build_city(line_as_array.parent_code, line_as_array)
    else
      country_parse(line_as_array)
    end
  end

  def country_parse(line_as_array) # 需要找到对应的市 市信息存贮在省
    if province = find_province(trans_country_code_to_province_code(line_as_array.code))
      province[:cities].each do |c|
        c[:counties] << line_as_array.build_country if c[:code] == line_as_array.parent_code
      end
    end
  end

  def trans_country_code_to_province_code(code)
    code[0..1] + '0000'
  end

  def find_province(code)
    province = nil
    @areas.each do |prov|
      return province = prov if code == prov[:code]
    end
    province
  end

  def build_city(admin_code, line_as_array)
    {
      admin_code: admin_code,
      code: line_as_array.code,
      counties: [],
      name: line_as_array.name
    }
  end
end

class LineAsArray
  attr_accessor :code, :parent_code, :name

  def initialize(line)
    @code = line[0]
    @name = line[1]
    @parent_code = line[4]
  end

  def is_province?
    CN_CODE == parent_code
  end

  # def is_zxs?
  #   ZXS_ARY.include? code
  # end

  def build_province
    {
      code: code,
      cities: [],
      name: name
    }
  end

  def build_country
    {
      admin_code: parent_code,
      code: code,
      name: name
    }
  end

end
