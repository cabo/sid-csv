require 'json'
require 'csv'

module CSV::SID

  def csv_line(source, *entries)
    entries.map do |entry|
      case entry
      in String
        source[entry]
      in Symbol
        entry.to_s
      end
    end
  end

  def csv_lines(source, *entries)
    if source
      source.map do |row|
        csv_line(row, *entries)
      end
    end
  end

  def sid_csv_from_data(sid_data)
    [
      csv_line(sid_data, :"ietf-sid-file", "module-name", "module-revision",
               "sid-file-revision", "sid-file-status"),
      csv_line(sid_data, :description, "description"),
      *csv_lines(sid_data["dependency-revision"], :dependency,
                 "module-name", "module-revision"),
      *csv_lines(sid_data["assignment-range"], :range, "entry-point", "size"),
      *csv_lines(sid_data["item"], "sid", "namespace", "identifier", "status"),
    ]
  end

  def csv_hash(names, values)
    Hash[names.zip(values).filter{|k, v| v != ""}]
  end

  def csv_store(csv, name, names, values)
    csv[name] ||= []
    csv[name] << csv_hash(names, values)
  end

  SID_FILE_TOP_LEVEL = "ietf-sid-file:sid-file"

  def sid_file_from_csv(sid_csv)
    {SID_FILE_TOP_LEVEL =>
     sid_csv.each_with_object({}) do |line, result|
       case line
       in ["ietf-sid-file", *values]
         result.merge!(csv_hash(["module-name", "module-revision",
                                 "sid-file-revision", "sid-file-status"], values))
       in ["description", *values]
         result.merge!(csv_hash(["description"], values))
       in ["dependency", *values]
         csv_store(result, "dependency-revision",
                   ["module-name", "module-revision"], values)
       in ["range", entry_point, size]
         csv_store(result, "assignment-range",
                   ["entry-point", "size"], [entry_point.to_s, size.to_s])
       in [sid, namespace, name, status]
         csv_store(result, "item",
                   ["namespace", "identifier", "sid", "status"],
                   [namespace, name, sid.to_s, status])
       end
     end
    }
  end

  def csv_generate(data)
    CSV.generate('') do |csv|
      data.each do |row|
        csv << row
      end
    end
  end

  def sid_data_from_file(text)
    JSON.load(text)[SID_FILE_TOP_LEVEL]
  end

  def json_dump(fn, value)
    File.write(fn, JSON.pretty_generate(value))
  end

end
