# frozen_string_literal: true

require "logger"
require "sequel"
require "csv"
require "netrc"

# collect auth info
netrc = Netrc.read("#{Dir.home}/.netrc.gpg")
credentials = netrc["database"]

PR = Sequel.postgres(database: "metadata",
                     host: "granby.kbs.msu.edu",
                     user: credentials["login"],
                     loggers: [Logger.new($stdout)],
                     password: credentials["password"])

table = PR[Sequel.qualify(:glbrc_mle_moisture, :plots)]

PR.transaction do
  CSV.foreach(ARGV[0]) do |row|
    next if row[0] == "pakbus"

    treatment, rep, shelter, footprint = row[1].split("_")
    p [treatment, rep, shelter, footprint]
    table.insert({ treatment: treatment,
                   replicate: rep,
                   shelter: shelter,
                   subplot: footprint })
  end
end
