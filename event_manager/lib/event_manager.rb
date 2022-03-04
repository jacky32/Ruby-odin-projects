require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone(number)
  number = number.to_s.tr("() -.", "")
  if number.length < 10
    'BAD NUMBER'
  elsif number.length == 10
    number
  elsif number.length == 11
    if number[0] == '1'
      number[1..10]
    else
      'BAD NUMBER'
    end
  else
    'BAD NUMBER'
  end
end

def clean_time(time)
  begin
    year = "20#{time.split(" ")[0].split("/")[0]}" unless time.split(" ")[0].split("/")[0].length != 2
    day = time.split(" ")[0].split("/")[1]
    month = time.split(" ")[0].split("/")[2]
    hours = time.split(" ")[1].split(":")[0]
    mins = time.split(" ")[1].split(":")[1]

    reg_date = Time.new(year, month, day, hours, mins, 0, "+01:00")
  rescue
    'INVALID'
  end
end

def best_hour(hours)
  hours.reduce(Hash.new(0)) do |a,b|
    a[b] += 1
    a
  end.max_by{|k,v| v}[0]
end

def best_day(days)
  days.reduce(Hash.new(0)) do |a,b|
    a[b] += 1
    a
  end.max_by{|k,v| v}[0]
end

puts 'Event Manager Initialized!'

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

hours = []
days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])
  reg_date = clean_time(row[:regdate])
  hours.push(reg_date.hour) unless reg_date == 'INVALID'
  days.push(reg_date.strftime("%A").downcase) unless reg_date == 'INVALID'

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

puts "Best hour is #{best_hour(hours)}"
puts "Best day is #{best_day(days)}"