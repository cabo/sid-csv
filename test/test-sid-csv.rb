# require 'yaml'
require_relative "../lib/sid-csv"
include CSV::SID

FILENAME = "ietf-system.sid"

sid_data = sid_data_from_file(File.read(FILENAME))

sid_csv_data = sid_csv_from_data(sid_data)

# Original data, with "1700" and nil
json_dump("ietf-system-csv.json", sid_csv_data)

generated_csv1 = csv_generate(sid_csv_data)

File.write("ietf-system.csv", generated_csv1)

converted_csv2 = CSV.parse(generated_csv1, nil_value: "", converters: :integer)

# CSV has done its magic, with 1700 and ""
json_dump("ietf-system-csv-2.json", converted_csv2)

File.write("ietf-system-csv-cddl.diag", `cddl ../data/sid-csv.cddl vp ietf-system-csv-2.json`)

# pp sid_file_from_csv(converted_csv2)
sid2 = sid_file_from_csv(converted_csv2)
json_dump("ietf-system-2.sid", sid2)
