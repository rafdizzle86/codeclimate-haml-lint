module HamlLint
  # Outputs report as a JSON document.
  class Reporter::CodeClimateReporter < Reporter
    def display_report(report)
      lints = report.lints
      grouped = lints.group_by(&:filename)
      grouped.map do |file|
        report_hash = file.last.map do |offense|
          {
            type: "issue",
            check_name: offense.linter.name,
            description: offense.message,
            categories: [offense.severity],
            location: {
              path: file.first,
              line: {
                begin: offense.line,
                end: offense.line
              }
            }
          }
        end
        log.log report_hash.to_json
      end
    end
  end
end
