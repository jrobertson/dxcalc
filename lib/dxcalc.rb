#!/usr/bin/env ruby

# file: dxcalc.rb

require 'dynarex'


class DxCalc

  def initialize(src: nil, sheet: nil)
    parse(sheet, src)
  end

  def parse(s, dx)

    raw_summary, raw_body = s.strip.split(/----*/)
    lines = raw_summary.gsub(/\n\n+/,"\n").lines
    declaration = lines.shift
    summary = lines.map {|x| x.match(/^(\w+):\s*([^\n]+)/).captures}.to_h

    sheet_summary = lines.map do |x| 
      cols = x.match(/^(\w+):\s*([^\n]+)/).captures
      [cols[0].to_sym, cols[1]]
    end.to_h

    body = raw_body.lstrip.lines.map {|x| x.chomp.split(/\s+#\s+/) }

    fields = declaration[/[^\(]+(?=\))/].split(/,\s*/).map(&:to_sym)
    columns = fields.zip(body).to_h

    a = dx.to_a
    dx_keys = a.first.keys

    @h = fields.inject({}) do |r,field|
    
      # look for the field in the following order
      # 1. data src
      # 2. summary
      # 3. sheet schema
      
      val = if dx_keys.include? field

        #a.map {|x| x[field].to_f }
        a.map {|x| x[field] }

      elsif sheet_summary.has_key? field
        columns[field].first
      end
      
      r.merge(field =>val)
    end

  end

  def to_h
    @h
  end
  
end
